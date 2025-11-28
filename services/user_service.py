from abc import abstractmethod
from bottle import request
from models.user import UserModel, User

#constructor
class UserService :
    def __init__(self):
        self.user_model = UserModel()

    #função que faz users receber toda a lista self.users da classe User.model do método get all
    def get_all(self):
        users = self.user_model.get_all()
        return users

    #função que salva os ids antigos da iteração de cada objeto user, salva um id novo adicionando + 1, se não tinha, 0, agora é 1
    #max procura o maior número da lista, se for vazia default é 0
    #as linhas das variáveis buscam as informações digitadas pelo user no html
    def save(self):
        last_id = max([u.id for u in self.user_model.get_all()], default=0)
        new_id = last_id + 1
        name = request.forms.get('name')
        email = request.forms.get('email')
        password = request.forms.get('password')
        telephone = request.forms.get('telephone')
        
        #salva a classe
        user = User(id=new_id, name=name, email=email, password=password, telephone=telephone)
        self.user_model.add_user(user)

    #dá pra entender oq é
    def get_by_id(self, user_id):
        return self.user_model.get_by_id(user_id)

    #edita o que o usuário colocar de novo
    def edit_user(self, user):
        name = request.forms.get('name')
        email = request.forms.get('email')
        password = request.forms.get('password')
        telephone = request.forms.get('telephone')

        user.name = name
        user.email = email
        user.password = password
        user.telephone = telephone

        self.user_model.update_user(user)

    #deleta
    def delete_user(self, user_id):
        self.user_model.delete_user(user_id)
