


# Contém Service de Cliente e visualiza Service de Vehicle


from bottle import Bottle, request, redirect, response
from .base_controller import BaseController
from services.cliente_service import ClienteService
from services.vehicle_service import VehicleService

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
        uid = request.get_cookie("user_id", secret='secret_key')
        if uid:
            return int(uid)
        return None

    def vitrine(self):
        user_id = self._get_user_id()
        if not user_id: return redirect('/login')

        cliente = self.cliente_service.get_by_id(user_id)
        if not cliente:
            return redirect('/cliente/perfil')

        carros_disponiveis = self.vehicle_service.get_available()
        
        return self.render('cliente_vitrine', carros=carros_disponiveis, cliente=cliente)

    def perfil(self):
        user_id = self._get_user_id()
        if not user_id: return redirect('/login')

        if request.method == 'POST':
            try:
                self.cliente_service.criar_ou_atualizar(
                    user_id=user_id,
                    nome=request.forms.get('name'),
                    telefone=request.forms.get('telephone'),
                    cpf=request.forms.get('cpf'),
                    endereco=request.forms.get('endereco')
                )
            except Exception as e:
                return f"Erro ao salvar: {e}"

            return redirect('/cliente/vitrine')

        else:
            cliente = self.cliente_service.get_by_id(user_id)
            return self.render('cliente_form', cliente=cliente)

cliente_routes = Bottle()
cliente_controller = ClienteController(cliente_routes)