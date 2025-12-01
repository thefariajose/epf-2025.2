from datetime import datetime
from models.locacao import Locacao, LocacaoModel
from models.locador import LocadorModel
from models.vehicles import VehicleModel

class LocacaoService:
    def __init__(self):
        self.locacao_model = LocacaoModel()
        self.locador_model = LocadorModel()
        self.vehicle_model = VehicleModel()
    #Aqui busca o dono do veículo, buscando pelo id do veículo no locador em especifico
    def _get_locador_by_vehicle_id(self, vehicle_id):
        all_locadores = self.locador_model.get_all()
        for locador in all_locadores:
            if not locador.veiculos: continue
            for veiculo in locador.veiculos:
                if veiculo.id == vehicle_id:
                    return locador
        return None
    #Faz o calculo total, com base no numero de dias escolhidos, pega a quantidade deles
    #multiplica pelo preço da diaria e multiplica por 1.3 que seria uma taxa para a empresa de locação
    def calcular_total(self, data_inicio_str, data_fim_str, preco_diaria):
        try:
            d1 = datetime.strptime(data_inicio_str, '%Y-%m-%d')
            d2 = datetime.strptime(data_fim_str, '%Y-%m-%d')
            dias = (d2 - d1).days
            if dias < 0: raise Exception("Data final anterior à inicial.")
            if dias == 0: dias = 1
            return round((dias * float(preco_diaria)) * 1.3, 2)
        except ValueError:
            raise Exception("Erro no cálculo ou formato de data.")
    #aqui cria uma solicitação, na parte do cliente, verifica se o veículo existe e lança uma exceção
    #se o locador não é encontrado tam´bem
    #calcula o valor total, salva o ide e cria uma noca locação com status de negociando
    def criar_solicitacao(self, client_id, vehicle_id, data_inicio, data_fim):
        veiculo = self.vehicle_model.get_by_id(vehicle_id)
        if not veiculo: raise Exception("Veículo não encontrado")
        locador = self._get_locador_by_vehicle_id(vehicle_id)
        if not locador: raise Exception("Locador não encontrado para este veículo.")
        valor_total = self.calcular_total(data_inicio, data_fim, veiculo.preco_diaria)
        all_locacoes = self.locacao_model.get_all()
        last_id = max([l.id for l in all_locacoes], default=0)
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
        self.locacao_model.add(nova_locacao)
        return nova_locacao
    #pega os veiculos alocados do locador
    def get_by_locador(self, locador_id):
        locacoes_do_locador = []
        for l in self.locacao_model.get_all():
            if l.locador_id == locador_id:
                locacoes_do_locador.append(l)
        return locacoes_do_locador
    #pega os veiculos alocados do cliente
    def get_by_cliente(self, cliente_id):
        locacoes_do_cliente = []
        for l in self.locacao_model.get_all():
            if l.cliente_id == cliente_id:
                locacoes_do_cliente.append(l)
        return locacoes_do_cliente
    #busca o contrato do alugel inicialmente e altera para o novo
    #se for aceito pelo dono o veiculo fica indisponivel, se o status
    #for concluido ou rejeitado permanece disponivel, ele atualiza como for definido
    def alterar_status(self, locacao_id, novo_status):
        locacao = self.locacao_model.get_by_id(locacao_id)
        if not locacao: return False
        locacao.status = novo_status
        self.locacao_model.update(locacao)
        veiculo = self.vehicle_model.get_by_id(locacao.veiculo_id)
        if veiculo:
            if novo_status == 'aceito':
                veiculo.is_disponivel = False
            elif novo_status in ['concluido', 'rejeitado']:
                veiculo.is_disponivel = True
            self.vehicle_model.update(veiculo)
            locador = self._get_locador_by_vehicle_id(veiculo.id)
            if locador:
                for i, v in enumerate(locador.veiculos):
                    if v.id == veiculo.id:
                        locador.veiculos[i] = veiculo
                        break
                self.locador_model.update(locador)
        return True