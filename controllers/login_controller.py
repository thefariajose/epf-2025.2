from bottle import Bottle, request, response
from .base_controller import BaseController
from services.login_service import LoginService

class LoginController(BaseController):
    def __init__(self, app):
        super().__init__(app)
        self.login_service = LoginService()
        self.setup_routes()
        #rotas definidas
    def setup_routes(self):
        self.app.route('/login', method=['GET', 'POST'], callback=self.login)
        self.app.route('/logout', method='GET', callback=self.logout)
    #utilização do autenticate na pagina inicial, dependendo do atributo do is locador
    #redireciona para ou uma pagina ou outra
    #também cria um cooke, se o usuário existe, salva o id  e salva a secret key, que é um código
    #que adiciona ao id uma assinatura que gera mais segurança
    def login(self):
        if request.method == 'GET':
            return self.render('login')
        else:
            user = self.login_service.authenticate()
            if user:
                response.set_cookie("user_id", str(user.id), secret='secret_key')
                is_locador = str(user.is_locador).lower() in ('true', 'on', '1')
                if is_locador:
                    return self.redirect('/dashboard-locador') 
                else:
                    return self.redirect('/cliente/vitrine') 
            else:
                return self.render('login', error="Email ou senha incorretos")
    #opção de deletar o cookie e o id, para que o login possa ser refeito
    def logout(self):
        response.delete_cookie("user_id")
        return self.redirect('/login')

login_routes = Bottle()
login_controller = LoginController(login_routes)