from datetime import datetime
from models.locacao import Locacao, LocacaoModel
from models.locador import LocadorModel
from models.vehicles import VehicleModel

class LocacaoService:
    def __init__(self):
        self.locacao_model = LocacaoModel()
        self.locador_model = LocadorModel()
        self.vehicle_model = VehicleModel()

    def _get_locador_by_vehicle_id(self, vehicle_id):
        self.locador_model.locadores = self.locador_model._load()
        for locador in self.locador_model.get_all():
            for veiculo in locador.veiculos:
                if veiculo.id == vehicle_id:
                    return locador
        return None

    def calcular_total(self, data_inicio_str, data_fim_str, preco_diaria):
        d1 = datetime.strptime(data_inicio_str, '%Y-%m-%d')
        d2 = datetime.strptime(data_fim_str, '%Y-%m-%d')
        
        dias = (d2 - d1).days
        if dias < 1: dias = 1 
        
        total = (dias * preco_diaria) * 1.3
        return round(total, 2)

    def criar_solicitacao(self, client_id, vehicle_id, data_inicio, data_fim):
        veiculo = self.vehicle_model.get_by_id(vehicle_id)
        if not veiculo: raise Exception("Veículo não encontrado")

        locador = self._get_locador_by_vehicle_id(vehicle_id)
        if not locador: raise Exception("Locador não encontrado para este veículo")


        valor_total = self.calcular_total(data_inicio, data_fim, veiculo.preco_diaria)


        self.locacao_model.locacoes = self.locacao_model._load()
        last_id = max([l.id for l in self.locacao_model.get_all()], default=0)
        
        nova_locacao = Locacao(
            id=last_id + 1,
            locador_id=locador.id,
            cliente_id=client_id,
            veiculo_id=vehicle_id,
            data_inicio=data_inicio,
            data_fim=data_fim,
            valor_total=valor_total,
            status='em_negociacao'
        )
        

        self.locacao_model.add_locacao(nova_locacao)
        
        return nova_locacao

    def get_by_locador(self, locador_id):
        self.locacao_model.locacoes = self.locacao_model._load()
        return [l for l in self.locacao_model.get_all() if l.locador_id == locador_id]

    def get_by_cliente(self, cliente_id):
        self.locacao_model.locacoes = self.locacao_model._load()
        return [l for l in self.locacao_model.get_all() if l.cliente_id == cliente_id]
    
    def get_by_id(self, locacao_id):
        return self.locacao_model.get_by_id(locacao_id)

    def alterar_status(self, locacao_id, novo_status):
        self.locacao_model.locacoes = self.locacao_model._load()
        locacao = self.locacao_model.get_by_id(locacao_id)
        
        if locacao:
            locacao.status = novo_status
            self.locacao_model.update_locacao(locacao)
            
            # Lógica de disponibilidade do veículo
            veiculo = self.vehicle_model.get_by_id(locacao.veiculo_id)
            if veiculo:
                if novo_status == 'aceito':
                    veiculo.is_disponivel = False
                elif novo_status == 'concluido' or novo_status == 'rejeitado':
                    veiculo.is_disponivel = True
                
                self.vehicle_model.update(veiculo)
                
                locador = self._get_locador_by_vehicle_id(veiculo.id)
                if locador:
                    for i, v in enumerate(locador.veiculos):
                        if v.id == veiculo.id:
                            locador.veiculos[i] = veiculo
                            break
                    self.locador_model.update_locador(locador)
            return True
        return False