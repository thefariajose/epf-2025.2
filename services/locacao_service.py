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
        # Busca qual locador possui o veículo com este ID
        self.locador_model.locadores = self.locador_model._load()
        for locador in self.locador_model.get_all():
            if not locador.veiculos: continue # Pula se não tiver veículos
            
            for veiculo in locador.veiculos:
                if veiculo.id == vehicle_id:
                    return locador
        return None

    def calcular_total(self, data_inicio_str, data_fim_str, preco_diaria):
        # 1. Validação básica se os campos vieram vazios
        if not data_inicio_str or not data_fim_str:
            raise Exception("As datas de início e fim são obrigatórias.")

        try:
            # 2. Converte string (YYYY-MM-DD) para objeto de data real
            d1 = datetime.strptime(data_inicio_str, '%Y-%m-%d')
            d2 = datetime.strptime(data_fim_str, '%Y-%m-%d')
            
            # 3. Calcula a diferença de dias
            dias = (d2 - d1).days
            
            if dias < 0:
                raise Exception("A data final não pode ser anterior à data inicial.")
            
            if dias == 0: 
                dias = 1 # Cobra pelo menos 1 dia
            
            # 4. Garante que o preço é um número (float) e calcula
            preco = float(preco_diaria)
            
            # Cálculo: (Dias * Preço) + 30%
            total = (dias * preco) * 1.3
            
            return round(total, 2)
            
        except ValueError:
            # Erro comum se a data vier em formato errado
            raise Exception("Formato de data inválido ou erro no cálculo.")

    def criar_solicitacao(self, client_id, vehicle_id, data_inicio, data_fim):
        # 1. Busca veículo atualizado
        self.vehicle_model.vehicles = self.vehicle_model._load()
        veiculo = self.vehicle_model.get_by_id(vehicle_id)
        if not veiculo: raise Exception("Veículo não encontrado")

        # 2. Busca o dono do veículo (Locador)
        locador = self._get_locador_by_vehicle_id(vehicle_id)
        if not locador: 
            # DICA: Isso acontece se você apagou o locador mas não o vehicle.json
            raise Exception("ERRO CRÍTICO: Locador não encontrado para este veículo. Limpe os dados em data/.")

        # 3. Calcula preço usando a função corrigida
        valor_total = self.calcular_total(data_inicio, data_fim, veiculo.preco_diaria)

        # 4. Gera ID e cria Locação
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
            
            # Lógica de Disponibilidade do Veículo
            veiculo = self.vehicle_model.get_by_id(locacao.veiculo_id)
            if veiculo:
                if novo_status == 'aceito':
                    veiculo.is_disponivel = False
                elif novo_status == 'concluido' or novo_status == 'rejeitado':
                    veiculo.is_disponivel = True
                
                self.vehicle_model.update(veiculo)
                
                # Sincroniza com a lista interna do locador
                locador = self._get_locador_by_vehicle_id(veiculo.id)
                if locador:
                    for i, v in enumerate(locador.veiculos):
                        if v.id == veiculo.id:
                            locador.veiculos[i] = veiculo
                            break
                    self.locador_model.update_locador(locador)
            return True
        return False