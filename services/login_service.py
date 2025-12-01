from bottle import request
from models.user import UserModel

class LoginService:
    def __init__(self):
        self.user_model = UserModel()
    #Requisita que o usuário coloque um email e uma senha, busca os já cadastrados e compara,
    #Caso o email e a senha existam ele entra, caso não é barrado
    #a exception era pra resolver um problema que estava sendo gerado por caso existir o email
    #E a senha ser nula
    def authenticate(self):
        email = request.forms.get('email')
        password = request.forms.get('password')
        user = self.user_model.get_by_email(email)
        try:
            if user and user.password == password:
                return user
        except AttributeError:
            return None
        return None