# -*- coding: utf-8 -*-
"""
** Populate blaseball SQL server, as of Delta Eon **

Created:        2023-01-15
Last Update:    2023-01-22

STILL TO DO:
    - Split out and create player_positions
    - Split out and create player_modifications
    - Load, split out and create team_modifications
    - Redo Games, to only replace unfinished w/ finished?
    - Start integrating PARSERS! (Abyline, Fed, etc)
    - So many triggers (url_slug, hash, do child table data this way)
    - When hashed, trim down records from "raw" to "clean(?)" with dedupes
    - THEN we can talk functions and views

@author: ifhbiff
"""
import numpy as np
import pandas as pd
import sqlalchemy
from datetime import datetime
from sqlalchemy.orm import sessionmaker
import configparser

def read_config():
    config = configparser.ConfigParser()
    config.read('datablase_config.ini')
    return config


def pick_rating(categoryRatings, category):
    for item in categoryRatings:
        if item["name"] == category:
            return item["stars"]


def pick_attribute(attributes, name):
    for item in attributes:
        if item["name"] == name:
            return item["value"]
   

def raw_rating(attributes, category):
    if category == "batting":
        attr1 = pick_attribute(attributes, "Sight")
        attr2 = pick_attribute(attributes, "Thwack")
        attr3 = pick_attribute(attributes, "Ferocity")
    elif category == "pitching":
        attr1 = pick_attribute(attributes, "Control")
        attr2 = pick_attribute(attributes, "Stuff")
        attr3 = pick_attribute(attributes, "Guile")
    elif category == "defense":
        attr1 = pick_attribute(attributes, "Reach")
        attr2 = pick_attribute(attributes, "Magnet")
        attr3 = pick_attribute(attributes, "Reflex")
    elif category == "running":
        attr1 = pick_attribute(attributes, "Hustle")
        attr2 = pick_attribute(attributes, "Stealth")
        attr3 = pick_attribute(attributes, "Dodge")
    elif category == "vibes":
        attr1 = pick_attribute(attributes, "Thrive")
        attr2 = pick_attribute(attributes, "Survive")
        attr3 = pick_attribute(attributes, "Drama")
    return 5 * (attr1 + attr2 + attr3) / 3


def get_object_page_token(object_type):
    result = conn.execute("SELECT page_token from delta_data.chron_load_page_tokens WHERE object_name = '{0}';".format(object_type))
    values = result.fetchall()    
    #Ugly, but will always result one record, one field
    return values[0][0] 

def set_object_page_token(object_type, page_token):
    conn.execute("UPDATE delta_data.chron_load_page_tokens SET page_token = '{1}', valid_until = now() WHERE object_name = '{0}';"
                 .format(object_type, page_token))    


config = read_config()

print('Connecting to Postgres')
engine = sqlalchemy.create_engine('postgresql+psycopg2://{0}:{1}@{2}:{3}/{4}'.format
                                  (config['DATABLASE']['user'],config['DATABLASE']['password'],config['DATABLASE']['host'],
                                   config['DATABLASE']['port'],config['DATABLASE']['db']))
Session = sessionmaker(bind=engine)
session = Session()
conn = engine.connect()

attribute_list = [
    "Sight",
    "Thwack",
    "Ferocity",
    "Control",
    "Stuff",
    "Guile",
    "Reach",
    "Magnet",
    "Reflex",
    "Hustle",
    "Stealth",
    "Dodge",
    "Thrive",
    "Survive",
    "Drama"
]

append_game_states = [
    "awayScore",
    "homeScore",
    "inning",
    "ballsNeeded",
    "strikesNeeded",
    "outsNeeded",
    "totalBases",
    "shame"
]

append_events = [
    "data.changedState.balls",
    "data.changedState.strikes",
    "data.changedState.outs",
    "data.changedState.awayScore",
    "data.changedState.homeScore",
    "data.changedState.inning",
    "data.changedState.batter.id",
    "data.changedState.pitcher.id"
]


def playersMain():
    print('Starting playersMain()')
    pages = 1
    
    next_page_token = get_object_page_token('players')
    
    #loop through results from API, starting at stored page token each time, until no more records 
    while True:

        raw_players = pd.read_json("https://api2.sibr.dev/chronicler/v0/versions?kind=player&order=asc&page={0}".format(next_page_token))  
  

        if raw_players.shape[0] == 0:
            print('No additional records found beyond this timestamp.')
            break
        
        
        normPlayer = pd.json_normalize(raw_players["items"])
        player = normPlayer[["entity_id", "data.name","valid_from","valid_to"]].copy()
        player.rename(columns={"entity_id":"player_id", "data.name":"player_name","valid_to":"valid_until"}, inplace=True) 
        player["temprosterlocation"] = normPlayer["data.rosterSlots"].apply(lambda x: ";".join([y['location'] for y in x]))
        player["temprosterindex"] = normPlayer["data.rosterSlots"].apply(lambda x: [y['orderIndex'] for y in x])
        player["temprosterindex"] = player["temprosterindex"].apply(lambda x: x[0] if len(x) > 0 else np.nan)
        player["tempteamid"] = normPlayer["data.team.id"].apply(lambda x: x["id"] if type(x) == dict else x)
        player["tempheatmap"] = normPlayer["data.playerHeatMaps"].apply(lambda x: [y['currentValue'] for y in x])
        player["tempmodifications"] =  normPlayer["data.modifications"].apply(lambda x: ";".join([y['modification']['name'] for y in x]))    
        player["temppositions"] = normPlayer["data.positions"].apply(lambda p: [(q["x"], q["y"]) for q in p])
        player["temppositions"]= player["temppositions"].apply(lambda x: x[0] if len(x) > 0 else np.nan)
        player["temppositionname"] = normPlayer["data.positions"].apply(lambda p: [(q["positionName"]) for q in p])
        player["temppositionname"]= player["temppositionname"].apply(lambda x: x[0] if len(x) > 0 else np.nan)
        player["batting_rating"] = normPlayer["data.attributes"].apply(raw_rating, args=("batting",))
        player["pitching_rating"] = normPlayer["data.attributes"].apply(raw_rating, args=("pitching",))
        player["defense_rating"] = normPlayer["data.attributes"].apply(raw_rating, args=("defense",))
        player["running_rating"] = normPlayer["data.attributes"].apply(raw_rating, args=("running",))
        player["vibes_rating"] = normPlayer["data.attributes"].apply(raw_rating, args=("vibes",))
        
        for attr in attribute_list:
            player[attr.lower()] = normPlayer["data.attributes"].apply(pick_attribute, args=(attr,))

        next_page_token = raw_players["next_page"][0]
        
        player.to_sql('players',engine,schema='delta_data',if_exists='append',index=False)  
        
        print("{0}: processed player page {1}, {2} new records added.".format(datetime.now(), pages, player.shape[0]))
        
        #If we had less than the max records for this API (1000), we hit the last page
        if raw_players.shape[0] < 1000:
            set_object_page_token('players',next_page_token)   
            #For now, this procedure truncates and replaces, so just do once we're done w/ players.
            conn.execute("CALL delta_data.populate_player_heatmaps()")
            break
         
        pages +=1     
        
        
def teamsMain():
    print('Starting teamsMain()')
    pages = 1

    next_page_token = get_object_page_token('teams')
    
    #loop through results from API, starting at stored page token each time, until no more records 
    while True:
        
        raw_teams = pd.read_json("https://api2.sibr.dev/chronicler/v0/versions?kind=team&order=asc&page={0}".format(next_page_token))     
        
        if raw_teams.shape[0] == 0:
            print('No additional records found beyond this timestamp.')
            break

        normTeams = pd.json_normalize(raw_teams["items"])
        
        #Lets go on a side adventure to do rosters!
        normRostersWide = pd.json_normalize(normTeams["data.roster"])
        normRosterSlots = {}  
        #loop through all roster columns to make a single column RosterSlot dataframe
        i = 0
        for x in normRostersWide.items():
            normRosterSlots[i] = pd.json_normalize(normRostersWide[i])
            normRosterSlots[i]["team_id"] = normTeams["entity_id"]
            normRosterSlots[i]["valid_from"] = normTeams["valid_from"]
            normRosterSlots[i]["valid_until"] = normTeams["valid_to"]
            
            #remove empties
            normRosterSlots[i] = normRosterSlots[i][normRosterSlots[i]["id"].notna()]
            
            normRosterSlots[i]["active"]= normRosterSlots[i]["rosterSlots"].apply(lambda x: [y['active'] for y in x])
            normRosterSlots[i]["active"]= normRosterSlots[i]["active"].apply(lambda x: x[0] if len(x) > 0 else np.nan)
            normRosterSlots[i]["location"]= normRosterSlots[i]["rosterSlots"].apply(lambda x: [y['location'] for y in x])
            normRosterSlots[i]["location"]= normRosterSlots[i]["location"].apply(lambda x: x[0] if len(x) > 0 else np.nan)
            normRosterSlots[i]["orderIndex"]= normRosterSlots[i]["rosterSlots"].apply(lambda x: [y['orderIndex'] for y in x])
            normRosterSlots[i]["orderIndex"]= normRosterSlots[i]["orderIndex"].apply(lambda x: x[0] if len(x) > 0 else np.nan)
    
            if i ==0:
                normRosterAll = normRosterSlots[0].copy()
            else:
                normRosterAll = pd.concat([normRosterAll, normRosterSlots[i]])
    
            i +=1
        
        teamRoster = normRosterAll[["id", "team_id", "valid_from","valid_until", "active", "location", "orderIndex"]].copy()
        teamRoster.rename(columns={"id":"player_id","orderIndex":"order_index"}, inplace=True)
        
        teamRoster.to_sql('team_roster',engine,schema='delta_data',if_exists='append',index=False)
        
        #OK now back to actual team stuff    
        teams = normTeams[["entity_id", "valid_from", "valid_to", "data.activeTeam", "data.division.id", "data.locationName",
                           #"data.modifications", 
                           "data.name", "data.nickname","data.primaryColor","data.secondaryColor",
                           "data.shorthand","data.slogan"]].copy()
        teams.rename(columns={"entity_id":"team_id", "valid_to":"valid_until", "data.activeTeam":"active", "data.division.id":"tempdivision",
                              "data.locationName":"location", 
                              #"data.modifications":"tempmodifications", 
                              "data.name":"fullname","data.nickname":"nickname","data.primaryColor":"team_primarycolor",
                              "data.secondaryColor":"team_secondarycolor","data.shorthand":"team_shorthand","data.slogan":"team_slogan",
                              }, inplace=True)
        
        teams["losses"]= normTeams["data.standings"].apply(lambda x: [y['losses'] for y in x])
        teams["losses"]= teams["losses"].apply(lambda x: x[0] if len(x) > 0 else np.nan)
        teams["wins"]= normTeams["data.standings"].apply(lambda x: [y['wins'] for y in x])
        teams["wins"]= teams["wins"].apply(lambda x: x[0] if len(x) > 0 else np.nan)
        teams["season_id"]= normTeams["data.standings"].apply(lambda x: [y['seasonId'] for y in x])
        teams["season_id"]= teams["season_id"].apply(lambda x: x[0] if len(x) > 0 else np.nan)
        #teams['tempmodifications'] = json.dumps(teams['tempmodifications'])
         
            
        next_page_token = raw_teams["next_page"][0]
        
        teams.to_sql('teams',engine,schema='delta_data',if_exists='append',index=False)  
    
        print("{0}: processed team page {1}, records {2}.".format(datetime.now(), pages, teams.shape[0]))
 
        #If we had less than the max records for this API (1000), we hit the last page
        if raw_teams.shape[0] < 1000:
            set_object_page_token('teams',next_page_token)      
            break
     
        pages +=1  


def gameEventsMain():
    print('Starting gameEventsMain()')
    pages = 1
    
    next_page_token = get_object_page_token('game-events')
    
    while True:

        raw_game_events = pd.read_json("https://api2.sibr.dev/chronicler/v0/game-events?order=asc&page={}".format(next_page_token))        

        if raw_game_events.shape[0] == 0:
            print('No additional records found beyond this timestamp.')
            break

        norm_game_events = pd.json_normalize(raw_game_events["items"])
        game_events = norm_game_events[["game_id","timestamp"]].copy()
        game_events["bases_occupied"]= norm_game_events["data.changedState.baserunners"].apply(lambda x: [y['base'] for y in x] if type(x)==list else x)
        game_events["baserunner_ids"]= norm_game_events["data.changedState.baserunners"].apply(lambda x: [y['id'] for y in x] if type(x)==list else x)
        events_to_append = norm_game_events[["data.displayOrder","data.displayText"]].copy()
        for event in append_events:

            if event in norm_game_events:
                events_to_append[event] = norm_game_events[event]
            else:
                events_to_append[event] = np.nan

        game_events = game_events.join(events_to_append)
        game_events.rename(columns={"data.displayOrder":"display_order","data.displayText":"display_text","data.changedState.batter.id":"batter_id",
                                    "data.changedState.pitcher.id":"pitcher_id","data.changedState.balls":"balls",
                                    "data.changedState.strikes":"strikes","data.changedState.outs":"outs","data.changedState.awayScore":"away_score",
                                    "data.changedState.homeScore":"home_score","data.changedState.inning":"inning"}, inplace=True)


        next_page_token = raw_game_events["next_page"][0]

        game_events.to_sql('game_events_raw',engine,schema='delta_data',if_exists='append',index=False)               
    
        print("{0}: processed game-event page {1}, records {2}.".format(datetime.now(), pages, game_events.shape[0]))
 
        #If we had less than the max records for this API (5000 for game-events?), we hit the last page
        if raw_game_events.shape[0] < 5000:
            set_object_page_token('game-events',next_page_token)      
            break
     
        pages +=1
        

def gamesMain():
    print('Starting gamesMain()')
    pages = 1

    #Unlike the others, for now I'm truncating and full replacing from entities rather than versions
    #Because there aren't a ton of game objects, and it allows us the easily
    #Get the data for completed games that we didn't have before.
    #Also ... laziness.
    conn.execute("TRUNCATE TABLE delta_data.games;")
    
    raw_games = pd.read_json("https://api2.sibr.dev/chronicler/v0/entities?kind=game")
    
    #Start here with default token in case there's an issue and zero come back, so it can set properly
    next_page_token = 'AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA='
    while True:    
        
        #Because games is from versions, count in there isn't as big, better to keep calling and check for zero?
        if raw_games.shape[0] == 0:
            set_object_page_token('games',next_page_token) 
            break
        
        norm_games = pd.json_normalize(raw_games["items"])
        games = norm_games[["entity_id","data.seasonId","data.day","data.cancelled","data.complete",
                            "data.awayPitcher.id","data.awayTeam.id","data.homePitcher.id","data.homeTeam.id",
                            "data.gameLoserId", "data.gameWinnerId",
                            "data.weather.name","data.numberInSeries","data.seriesLength"]] .copy()
        
        games.rename(columns={"entity_id":"game_id","data.seasonId":"season_id", "data.day":"gameday", "data.cancelled":"cancelled","data.complete":"completed",
                              "data.awayPitcher.id":"away_pitcher_id","data.awayTeam.id":"away_team_id",
                              "data.homePitcher.id":"home_pitcher_id","data.homeTeam.id":"home_team_id",
                              "data.gameLoserId":"losing_team_id","data.gameWinnerId":"winning_team_id",
                              "data.weather.name":"weather", "data.numberInSeries":"number_in_series","data.seriesLength":"series_length"}, inplace=True)
        interim_game_states = pd.json_normalize(norm_games["data.gameStates"])   
        norm_game_states = pd.json_normalize(interim_game_states[0])
        game_states_to_append = norm_game_states[["awayScore","homeScore","inning","ballsNeeded","strikesNeeded","outsNeeded",
                                                  "totalBases","shame"]].copy()
        game_states_to_append.rename(columns={"awayScore":"away_score","homeScore":"home_score","inning":"innings",
                                              "ballsNeeded":"balls_needed","strikesNeeded":"strikes_needed","outsNeeded":"outs_needed",
                                              "totalBases":"total_bases"}, inplace=True)
        games = games.join(game_states_to_append)
        games.to_sql('games',engine,schema='delta_data',if_exists='append',index=False)
        
        next_page = raw_games["next_page"][0]
        print("{0}: processed games page {1}, records {2}.".format(datetime.now(), pages, games.shape[0]))
          
        #If we've gotten this far, get the next page of events
        raw_games = pd.read_json("https://api2.sibr.dev/chronicler/v0/entities?kind=game&page={}".format(next_page))
        
        
if __name__ == "__main__":
    # execute only if run as a script
    playersMain()
    teamsMain()
    gamesMain()
    gameEventsMain()