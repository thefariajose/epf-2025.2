

#Contém as Services de Locador e Vehicles



from bottle import Bottle, request, redirect
from .base_controller import BaseController
from services.locador_service import LocadorService
from services.vehicle_service import VehicleService # <--- Importa o service de veículo

class LocadorController(BaseController):
    def __init__(self, app):
        super().__init__(app)
        # Instancia ambos os services
        self.locador_service = LocadorService()
        self.vehicle_service = VehicleService() 
        self.setup_routes()

    def setup_routes(self):
        self.app.route('/dashboard-locador', method='GET', callback=self.dashboard)
        self.app.route('/locador/perfil', method=['GET', 'POST'], callback=self.perfil)
        self.app.route('/locador/veiculo/add', method=['GET', 'POST'], callback=self.add_veiculo)
        self.app.route('/locador/veiculo/delete/<id:int>', method='GET', callback=self.delete_veiculo)

    def _get_user_id(self):
        return request.get_cookie("user_id", secret='secret_key')

    def dashboard(self):
        user_id = self._get_user_id()
        if not user_id: return redirect('/login')

        locador = self.locador_service.get_by_id(int(user_id))
        if not locador: return redirect('/locador/perfil')
            
        return self.render('dashboard_locador', locador=locador)

    def perfil(self):
        user_id = self._get_user_id()
        if not user_id: return redirect('/login')

        if request.method == 'GET':
            locador = self.locador_service.get_by_id(int(user_id))
            return self.render('locador_form', locador=locador)
        else:
            self.locador_service.criar_ou_atualizar(
                user_id=int(user_id),
                nome=request.forms.get('name'),
                telefone=request.forms.get('telephone'),
                cnpj=request.forms.get('cnpj')
            )
            return redirect('/dashboard-locador')

    def add_veiculo(self):
        user_id = self._get_user_id()
        if not user_id: return redirect('/login')

        if request.method == 'GET':
            return self.render('veiculo_form')
        else:
            # 1. ORQUESTRAÇÃO: Usa VehicleService para criar o carro
            dados = {
                'placa': request.forms.get('placa'),
                'marca': request.forms.get('marca'),
                'modelo': request.forms.get('modelo'),
                'ano': request.forms.get('ano'),
                'quilometragem': request.forms.get('quilometragem'),
                'preco_diaria': request.forms.get('preco_diaria')
            }
            novo_veiculo = self.vehicle_service.create_vehicle(dados)

            # 2. ORQUESTRAÇÃO: Usa LocadorService para vincular ao dono
            self.locador_service.vincular_veiculo(int(user_id), novo_veiculo)
            
            return redirect('/dashboard-locador')

    def delete_veiculo(self, id):
        user_id = self._get_user_id()
        if user_id:
            # 1. Remove do banco geral
            self.vehicle_service.delete_vehicle(id)
            # 2. Remove a referência no locador
            self.locador_service.desvincular_veiculo(int(user_id), id)
            
        return redirect('/dashboard-locador')

locador_routes = Bottle()
locador_controller = LocadorController(locador_routes)