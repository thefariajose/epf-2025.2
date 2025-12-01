from bottle import request
from models.user import UserModel, User

class UserService:
    def __init__(self):
        self.model = UserModel()
        
    def get_all(self):
        return self.model.get_all()

    def get_by_id(self, user_id):
        return self.model.get_by_id(user_id)

    def _validate_input(self, email, password):
        if '@' not in email or '.com' not in email:
            raise Exception("Email inválido: deve conter '@' e terminar com '.com'.")
        if password and len(password) <= 8:
             raise Exception("Senha inválida: deve conter mais de 8 caracteres.")

    def save(self):
        users = self.model.get_all()
        last_id = max([u.id for u in users], default=0)
        email = request.forms.get('email')
        password = request.forms.get('password')
        is_locador = request.forms.get('is_locador') == 'on'
        self._validate_input(email, password)
        user = User(id=last_id + 1, email=email, password=password, is_locador=is_locador)
        self.model.add(user)

    def edit_user(self, user):
        email = request.forms.get('email')
        password = request.forms.get('password')
        is_locador = request.forms.get('is_locador') == 'on'
        if '@' not in email or '.com' not in email:
             raise Exception("Email inválido.")
        user.email = email
        user.is_locador = is_locador
        if password:
            if len(password) <= 8: raise Exception("Senha curta demais.")
            user.password = password
        self.model.update(user)

    def delete_user(self, user_id):
        self.model.delete(user_id)