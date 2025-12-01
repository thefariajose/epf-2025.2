from bottle import Bottle, request, redirect
from .base_controller import BaseController
from services.cliente_service import ClienteService
from services.vehicle_service import VehicleService
from services.locacao_service import LocacaoService

class ClienteController(BaseController):
    def __init__(self, app):
        super().__init__(app)
        self.cliente_service = ClienteService()
        self.vehicle_service = VehicleService()
        self.locacao_service = LocacaoService()
        self.setup_routes()

    def setup_routes(self):
        self.app.route('/cliente/vitrine', method='GET', callback=self.vitrine)
        self.app.route('/cliente/perfil', method=['GET', 'POST'], callback=self.perfil)
        self.app.route('/cliente/alugar/<veiculo_id:int>', method=['GET', 'POST'], callback=self.solicitar_aluguel)
        self.app.route('/cliente/meus_alugueis', method='GET', callback=self.meus_alugueis)
        self.app.route('/cliente/aluguel/concluir/<locacao_id:int>', method='POST', callback=self.concluir_aluguel)

    def _get_user_id(self):
        uid = request.get_cookie("user_id", secret='secret_key')
        if uid: return int(uid)
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
                # Se der erro (validação), cai aqui e retorna o form com erro
                cliente = self.cliente_service.get_by_id(user_id)
                return self.render('cliente_form', cliente=cliente, error=str(e))
            
            # Se deu certo (não caiu no except), o código continua aqui fora:
            return redirect('/cliente/vitrine')
            
        else:
            cliente = self.cliente_service.get_by_id(user_id)
            return self.render('cliente_form', cliente=cliente)
        
    def solicitar_aluguel(self, veiculo_id):
        user_id = self._get_user_id()
        if not user_id: return redirect('/login')

        veiculo = self.vehicle_service.get_by_id(veiculo_id)
        if not veiculo or not veiculo.is_disponivel:
            return "Veículo indisponível."

        if request.method == 'GET':
            return self.render('alugar_veiculo', veiculo=veiculo)
        
        else:
            data_inicio = request.forms.get('data_inicio')
            data_fim = request.forms.get('data_fim')
            
            try:
                self.locacao_service.criar_solicitacao(
                    client_id=user_id, 
                    vehicle_id=veiculo_id, 
                    data_inicio=data_inicio, 
                    data_fim=data_fim
                )
            except Exception as e:
                import traceback
                traceback.print_exc()
                # Mostra o erro na tela (você pode adaptar a view se tiver campo de erro lá)
                return f"Erro ao solicitar aluguel: {str(e)}"
            
            return redirect('/cliente/meus_alugueis')
    
    def meus_alugueis(self):
        user_id = self._get_user_id()
        if not user_id: return redirect('/login')
        locacoes = self.locacao_service.get_by_cliente(user_id)
        dados_completos = []
        for l in locacoes:
            carro = self.vehicle_service.get_by_id(l.veiculo_id)
            dados_completos.append({'locacao': l, 'carro': carro})
        return self.render('meus_alugueis', dados=dados_completos)

    def concluir_aluguel(self, locacao_id):
        self.locacao_service.alterar_status(locacao_id, 'concluido')
        return redirect('/cliente/meus_alugueis')
    
            
cliente_routes = Bottle()
cliente_controller = ClienteController(cliente_routes)