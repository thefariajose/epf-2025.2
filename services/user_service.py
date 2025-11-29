from abc import abstractmethod
from bottle import request
from models.user import UserModel, User


class UserService :
    def __init__(self):
        self.user_model = UserModel()
        
    def get_all(self):
        users = self.user_model.get_all()
        return users

    def save(self):
        last_id = max([u.id for u in self.user_model.get_all()], default=0)
        new_id = last_id + 1
        email = request.forms.get('email')
        password = request.forms.get('password')
        is_locador = request.forms.get('is_locador') == 'on'
        
        user = User(id=new_id,
                    email=email,
                    password=password,
                    is_locador=is_locador)
        
        self.user_model.add_user(user)

    def get_by_id(self, user_id):
        return self.user_model.get_by_id(user_id)

    def edit_user(self, user):
        email = request.forms.get('email')
        password = request.forms.get('password')
        is_locador = request.forms.get('is_locador') == 'on'

        self.user_model.update_user(user)


    def delete_user(self, user_id):
        self.user_model.delete_user(user_id)
