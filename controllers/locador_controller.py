from bottle import Bottle, request, redirect
from .base_controller import BaseController
from services.locador_service import LocadorService
from services.vehicle_service import VehicleService
from services.locacao_service import LocacaoService

class LocadorController(BaseController):
    def __init__(self, app):
        super().__init__(app)
        self.locador_service = LocadorService()
        self.vehicle_service = VehicleService()
        self.locacao_service = LocacaoService()
        self.setup_routes()

    def setup_routes(self):
        self.app.route('/dashboard-locador', method='GET', callback=self.dashboard)
        self.app.route('/locador/perfil', method=['GET', 'POST'], callback=self.perfil)
        self.app.route('/locador/veiculo/add', method=['GET', 'POST'], callback=self.add_veiculo)
        self.app.route('/locador/veiculo/edit/<id:int>', method=['GET', 'POST'], callback=self.edit_veiculo)
        self.app.route('/locador/veiculo/delete/<id:int>', method='GET', callback=self.delete_veiculo)
        self.app.route('/locador/aluguel/aceitar/<id:int>', method='GET', callback=self.aceitar_aluguel)
        self.app.route('/locador/aluguel/rejeitar/<id:int>', method='GET', callback=self.rejeitar_aluguel)

    def _get_user_id(self):
        uid = request.get_cookie("user_id", secret='secret_key')
        if uid: return int(uid)
        return None

    def dashboard(self):
        user_id = self._get_user_id()
        if not user_id: return redirect('/login')
        locador = self.locador_service.get_by_id(user_id)
        if not locador: return redirect('/locador/perfil')   
        todas_locacoes = self.locacao_service.get_by_locador(user_id)
        solicitacoes = [l for l in todas_locacoes if l.status == 'em_negociacao'] #avançado
        historico = [l for l in todas_locacoes if l.status != 'em_negociacao'] #avançado
        
        return self.render('dashboard_locador', locador=locador, solicitacoes=solicitacoes, historico=historico)

    def perfil(self):
        user_id = self._get_user_id()
        if not user_id: return redirect('/login')
        if request.method == 'POST':
            try:
                self.locador_service.criar_ou_atualizar(
                    user_id=user_id,
                    nome=request.forms.get('name'),
                    telefone=request.forms.get('telephone'),
                    cnpj=request.forms.get('cnpj')
                )
            except Exception as e:
                locador = self.locador_service.get_by_id(user_id)
                return self.render('locador_form', locador=locador, error=str(e))
            return redirect('/dashboard-locador')
        else:
            locador = self.locador_service.get_by_id(user_id)
            return self.render('locador_form', locador=locador)

    def add_veiculo(self):
        user_id = self._get_user_id()
        if not user_id: return redirect('/login')
        
        if request.method == 'POST':
            try:
                dados = {
                    'placa': request.forms.get('placa'),
                    'marca': request.forms.get('marca'),
                    'modelo': request.forms.get('modelo'),
                    'ano': request.forms.get('ano'),
                    'quilometragem': request.forms.get('quilometragem'),
                    'preco_diaria': request.forms.get('preco_diaria')
                }
                novo_veiculo = self.vehicle_service.create_vehicle(dados)
                self.locador_service.vincular_veiculo(user_id, novo_veiculo)
            except Exception as e:
                return self.render('veiculo_form', veiculo=None, action='/locador/veiculo/add', error=str(e))
            return redirect('/dashboard-locador')
        else:
            return self.render('veiculo_form', veiculo=None, action='/locador/veiculo/add')

    def edit_veiculo(self, id):
        user_id = self._get_user_id()
        if not user_id: return redirect('/login')

        if request.method == 'POST':
            try:
                dados = {
                    'placa': request.forms.get('placa'),
                    'marca': request.forms.get('marca'),
                    'modelo': request.forms.get('modelo'),
                    'ano': request.forms.get('ano'),
                    'quilometragem': request.forms.get('quilometragem'),
                    'preco_diaria': request.forms.get('preco_diaria')
                }
                veiculo_atualizado = self.vehicle_service.update_vehicle(id, dados)
                if veiculo_atualizado:
                    self.locador_service.atualizar_veiculo_vinculado(user_id, veiculo_atualizado)
            except Exception as e:
                veiculo = self.vehicle_service.get_by_id(id)
                return self.render('veiculo_form', veiculo=veiculo, action=f'/locador/veiculo/edit/{id}', error=str(e))
            return redirect('/dashboard-locador')
        else:
            veiculo = self.vehicle_service.get_by_id(id)
            return self.render('veiculo_form', veiculo=veiculo, action=f'/locador/veiculo/edit/{id}')

    def delete_veiculo(self, id):
        user_id = self._get_user_id()
        if user_id:
            self.vehicle_service.delete_vehicle(id)
            self.locador_service.desvincular_veiculo(user_id, id)
        return redirect('/dashboard-locador')
    
    def aceitar_aluguel(self, id):
        user_id = self._get_user_id()
        if user_id:
            self.locacao_service.alterar_status(id, 'aceito')
        return redirect('/dashboard-locador')

    def rejeitar_aluguel(self, id):
        user_id = self._get_user_id()
        if user_id:
            self.locacao_service.alterar_status(id, 'rejeitado')
        return redirect('/dashboard-locador')

locador_routes = Bottle()
locador_controller = LocadorController(locador_routes)