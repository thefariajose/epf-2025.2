from bottle import Bottle, request
from .base_controller import BaseController
from services.user_service import UserService

class UserController(BaseController):
    #constructor, ele herda td do base controler
    def __init__(self, app):
        super().__init__(app)

        self.setup_routes()
        self.user_service = UserService()


    # Rotas User
    #faz o setup de 4 rotas, lista de usuários, adicionar usuário, editar usuário e deletar usuário
    #o GET é qd o usuário apenas visualiza os dados, o POSt é quando o usuário preenche o formulário e clica em salvar,
    #o navegador envia os dados de volta para a url
    def setup_routes(self):
        self.app.route('/users', method='GET', callback=self.list_users)
        self.app.route('/users/add', method=['GET', 'POST'], callback=self.add_user)
        self.app.route('/users/edit/<user_id:int>', method=['GET', 'POST'], callback=self.edit_user)
        self.app.route('/users/delete/<user_id:int>', method='POST', callback=self.delete_user)

    #list users pega os users do service e retorna para a route
    def list_users(self):
        users = self.user_service.get_all()
        return self.render('users', users=users)


    def add_user(self):
        if request.method == 'GET':
            return self.render('user_form', user=None, action="/users/add")
            #user_form reutiliza um arquivo html de formulário, user None é para começar zerado já que
            #está criando um usuário, para não quebrar o html o template passado é none caso esteja branco o
            #formulário. action é para onde os dados devem ser enviados quando o botão salvar for clicado
        else:
            # POST - salvar usuário
            self.user_service.save()
            #método save do services
            self.redirect('/login')
            #redirect de antes pra o users


    def edit_user(self, user_id):
        user = self.user_service.get_by_id(user_id)
        if not user:
            return "Usuário não encontrado"

        if request.method == 'GET':
            return self.render('user_form', user=user, action=f"/users/edit/{user_id}")
            #aqui ao invés de passar none está passando o usuário mesmo, o action muda
            #o lugar enviado para o formulário e o f é parainsrir o id corretamente (Não saquei 100%)
        else:
            # POST - salvar edição
            self.user_service.edit_user(user)
            self.redirect('/users')

    #autoexplicativo
    def delete_user(self, user_id):
        self.user_service.delete_user(user_id)
        self.redirect('/users')


user_routes = Bottle()
user_controller = UserController(user_routes)
