from models.vehicles import Vehicle, VehicleModel

class VehicleService:
    def __init__(self):
        self.model = VehicleModel()

    def _gerar_id(self):
        todos = self.model.get_all()
        if not todos: return 1
        return max([v.id for v in todos]) + 1

    def create_vehicle(self, dados_veiculo):
        # Gera ID e Cria o Objeto
        novo_id = self._gerar_id()
        
        novo_veiculo = Vehicle(
            id=novo_id,
            placa=dados_veiculo['placa'],
            marca=dados_veiculo['marca'],
            modelo=dados_veiculo['modelo'],
            ano=int(dados_veiculo['ano']),
            quilometragem=float(dados_veiculo.get('quilometragem', 0)),
            status='disponivel',
            is_disponivel=True,
            preco_diaria=float(dados_veiculo['preco_diaria'])
        )
        
        self.model.add(novo_veiculo)
        return novo_veiculo

    def get_all(self):
        return self.model.get_all()

    def get_available(self):
        return [v for v in self.model.get_all() if v.is_disponivel]

    def delete_vehicle(self, veiculo_id):
        self.model.delete(veiculo_id)