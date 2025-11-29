from bottle import Bottle, request, response
from .base_controller import BaseController
from services.login_service import LoginService

class LoginController(BaseController):
    def __init__(self, app):
        super().__init__(app)
        self.login_service = LoginService()
        self.setup_routes()
    # Rotas do login
    def setup_routes(self):
        self.app.route('/login', method=['GET', 'POST'], callback=self.login)
        self.app.route('/logout', method='GET', callback=self.logout)

    def login(self):
        if request.method == 'GET':
            return self.render('login')
        
        else:
            user = self.login_service.authenticate()
            
            if user:
                response.set_cookie("user_id", str(user.id), secret='sua-chave-secreta-aqui')
    
                is_locador = str(user.is_locador).lower() == 'true' or user.is_locador == 'on'
                
                if is_locador:
                    return self.redirect('/dashboard-locador') 
                else:
                    return self.redirect('/users') 
            else:
                return self.render('login', error="Email ou senha incorretos")

    def logout(self):
        response.delete_cookie("user_id")
        return self.redirect('/login')

login_routes = Bottle()
login_controller = LoginController(login_routes)