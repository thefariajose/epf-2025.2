from bottle import request
from models.user import UserModel

#Já que o Login não armazena dados não é necessário ter uma model só pro login.
#A lógica daqui pega os dados do User, que é aonde é cadastrado o usuário e compara com o recebido
class LoginService:
    def __init__(self):
        self.user_model = UserModel()
    
    def authenticate(self):
        email = request.forms.get('email')
        password = request.forms.get('password')
        user = self.user_model.get_by_email(email)
        
        try:
            if user.password == password and user.email == email:
                return user
        except AttributeError:
            return None