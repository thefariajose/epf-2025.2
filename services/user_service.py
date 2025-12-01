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
        
        #verificar se o email tem @ e .com e validação de senha se tem mais de 8 dígitos
        if '@' not in email or '.com' not in email:
            raise Exception("Email inválido: deve conter '@' e terminar com '.com'.")
        if len(password) <= 8:
            raise Exception("Senha inválida: deve conter mais de 8 caracteres.")

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

        #mesma coisa de antes
        if '@' not in email or '.com' not in email:
            raise Exception("Email inválido: deve conter '@' e terminar com '.com'.")
        #validação de senha caso queira alterar e tem menos de 8
        if password and len(password) <= 8:
             raise Exception("Senha inválida: deve conter mais de 8 caracteres.")
        #se manter a senha vazia, só mantém a de antes msm
        if password:
            user.password = password
            
        user.email = email
        user.is_locador = is_locador

        self.user_model.update_user(user)


    def delete_user(self, user_id):
        self.user_model.delete_user(user_id)
