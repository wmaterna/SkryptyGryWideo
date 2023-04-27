from typing import Any, Text, Dict, List
import random

import logging
import requests
import json
 
from rasa_sdk import Action, Tracker
from rasa_sdk.executor import CollectingDispatcher
 
 
food_random_choice_list = ['pizza', 'burger', 'tacos', 'ramen', 'sushi', 'pasta'];
API_URL = 'https://www.themealdb.com/api/json/v1/1/search.php?s='

class ActionFoodBot(Action):
   
    def name(self) -> Text:
        return "find_dish"

    def find_recipie(self, food_name):
        req_url = API_URL + food_name
        response = requests.get(req_url)
        print(response)
        if response.status_code == 200:
            name = response.json()['meals'][0]['strMeal']
            instructions = response.json()['meals'][0]['strInstructions']
            photo = response.json()['meals'][0]['strMealThumb']
        return name, instructions, photo

 
    def random_choose_food(self):
        rand_int = random.randint(0,5)
        computerchoice = food_random_choice_list[rand_int]
        return(computerchoice)
 
    def run(self, dispatcher: CollectingDispatcher,
            tracker: Tracker,
            domain: Dict[Text, Any]) -> List[Dict[Text, Any]]:
 
        user_choice = tracker.get_slot("dish")
        print(user_choice)
        comp_choice = self.random_choose_food()
        print(user_choice)
        if(user_choice == None):
            dispatcher.utter_message(text=f"Random food generating machiner choose: {comp_choice} for your dinner today.")
            name, instructions, photo = self.find_recipie(comp_choice)
            dispatcher.utter_message(text=f"Here is your: {name}'\n'Recipie:  {instructions} '\n'It looks like that:  {photo}")
        else:
            name, instructions, photo = self.find_recipie(user_choice)
            dispatcher.utter_message(text=f"Here is your: {name}'\n'Recipie:  {instructions} '\n'It looks like that:  {photo}\n")
        return []
