from bottle import Bottle
from controllers.user_controller import user_routes
from controllers.activity_controler import activity_routes
from controllers.login_controller import login_routes
def init_controllers(app: Bottle):
    app.merge(user_routes)
    app.merge(activity_routes)
    app.merge(login_routes)
    
