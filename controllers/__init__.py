from bottle import Bottle
from controllers.user_controller import user_routes
from controllers.activity_controler import activity_routes
from controllers.login_controller import login_routes
from controllers.locador_controller import locador_routes
from controllers.cliente_controller import cliente_routes
def init_controllers(app: Bottle):
    app.merge(user_routes)
    app.merge(activity_routes)
    app.merge(login_routes)
    app.merge(locador_routes)
    app.merge(cliente_routes)
    
