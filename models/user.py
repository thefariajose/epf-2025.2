import json
import os
from dataclasses import dataclass, asdict
from typing import List

DATA_DIR = os.path.join(os.path.dirname(__file__), '..', 'data')

class User:
    #Constructor
    def __init__(self, id, email, password, is_locador):
        self.id = id
        self.email = email
        self.password = password
        self.is_locador = is_locador

    def __repr__(self):
        return (f"User(id={self.id}, email='{self.email}', "
                f"password='{self.password}', is_locador='{self.is_locador}')")

    def to_dict(self):
        return {
            'id': self.id,
            'email': self.email,
            'password': self.password,
            'is_locador': self.is_locador
        }

    @classmethod
    def from_dict(cls, data):
        return cls(
            id=data['id'],
            email=data['email'],
            password=data['password'],
            is_locador=data['is_locador']
        )



class UserModel:
    FILE_PATH = os.path.join(DATA_DIR, 'users.json')
    
    #Constructors
    def __init__(self):
        self.users = self._load()

    def _load(self):
        if not os.path.exists(self.FILE_PATH):
            return []
        with open(self.FILE_PATH, 'r', encoding='utf-8') as f:
            data = json.load(f)
            return [User(**item) for item in data]

    def _save(self):
        with open(self.FILE_PATH, 'w', encoding='utf-8') as f:
            json.dump([u.to_dict() for u in self.users], f, indent=4, ensure_ascii=False)

   
    def get_all(self):
        return self.users

    def get_by_id(self, user_id: int):
        return next((u for u in self.users if u.id == user_id), None)

    def add_user(self, user: User):
        self.users.append(user)
        self._save()

    def get_by_email(self, email):
        return next((u for u in self.users if u.email == email), None)
    
    def update_user(self, updated_user: User):
        for i, user in enumerate(self.users):
            if user.id == updated_user.id:
                self.users[i] = updated_user
                self._save()
                break
            
    def delete_user(self, user_id: int):
        self.users = [u for u in self.users if u.id != user_id]
        self._save()
