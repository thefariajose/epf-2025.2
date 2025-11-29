from bottle import request
from models.user import UserModel

class LoginService:
    def __init__(self):
        self.user_model = UserModel()
    
    def authenticate(self):
        email = request.forms.get('email')
        password = request.forms.get('password')
        user = self.user_model.get_by_email(email)
        
        if user and user.password == password:
            return user

        return None