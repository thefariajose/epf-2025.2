


# Contém Service de Cliente e visualiza Service de Vehicle


from bottle import Bottle, request, redirect
from .base_controller import BaseController
from services.cliente_service import ClienteService
from services.vehicle_service import VehicleService # <--- Importa para ler carros

class ClienteController(BaseController):
    def __init__(self, app):
        super().__init__(app)
        self.cliente_service = ClienteService()
        self.vehicle_service = VehicleService()
        self.setup_routes()

    def setup_routes(self):
        self.app.route('/cliente/vitrine', method='GET', callback=self.vitrine)
        self.app.route('/cliente/perfil', method=['GET', 'POST'], callback=self.perfil)

    def _get_user_id(self):
        return request.get_cookie("user_id", secret='secret_key')

    def vitrine(self):
        user_id = self._get_user_id()
        if not user_id: return redirect('/login')

        cliente = self.cliente_service.get_by_id(int(user_id))
        if not cliente: return redirect('/cliente/perfil')

        # Usa o VehicleService para pegar os carros
        carros_disponiveis = self.vehicle_service.get_available()
        
        return self.render('cliente_vitrine', carros=carros_disponiveis, cliente=cliente)

    def perfil(self):
        user_id = self._get_user_id()
        if not user_id: return redirect('/login')

        if request.method == 'GET':
            cliente = self.cliente_service.get_by_id(int(user_id))
            return self.render('cliente_form', cliente=cliente)
        else:
            self.cliente_service.criar_ou_atualizar(
                user_id=int(user_id),
                nome=request.forms.get('name'),
                telefone=request.forms.get('telephone'),
                cpf=request.forms.get('cpf'),
                endereco=request.forms.get('endereco')
            )
            return redirect('/cliente/vitrine')

cliente_routes = Bottle()
cliente_controller = ClienteController(cliente_routes)