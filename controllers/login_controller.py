from bottle import Bottle, request, response
from .base_controller import BaseController
from services.login_service import LoginService

class LoginController(BaseController):
    def __init__(self, app):
        super().__init__(app)
        self.login_service = LoginService()
        self.setup_routes()

    def setup_routes(self):
        self.app.route('/login', method=['GET', 'POST'], callback=self.login)
        self.app.route('/logout', method='GET', callback=self.logout)

    def login(self):
        if request.method == 'GET':
            return self.render('login')
        else:
            user = self.login_service.authenticate()
            if user:
                response.set_cookie("user_id", str(user.id), secret='secret_key')
                is_locador = str(user.is_locador).lower() == 'true' or user.is_locador == 'on' or user.is_locador is True   
                if is_locador:
                    return self.redirect('/dashboard-locador') 
                else:
                    return self.redirect('/cliente/vitrine') 
            else:
                return self.render('login', error="Email ou senha incorretos")

    def logout(self):
        response.delete_cookie("user_id")
        return self.redirect('/login')

login_routes = Bottle()
login_controller = LoginController(login_routes)