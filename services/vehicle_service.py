from models.vehicles import Vehicle, VehicleModel

class VehicleService:
    def __init__(self):
        self.model = VehicleModel()
        
    def _generate_id(self):
        todos = self.model.get_all()
        return max([v.id for v in todos], default=0) + 1
    
    def _parse_vehicle_data(self, dados):
        try:
            return {
                'ano': int(dados['ano']),
                'quilometragem': float(dados.get('quilometragem', 0)),
                'preco_diaria': float(dados['preco_diaria'])
            }
        except ValueError:
            raise Exception("Dados numéricos inválidos.")

    def create_vehicle(self, dados_veiculo):
        parsed = self._parse_vehicle_data(dados_veiculo)
        
        novo_veiculo = Vehicle(
            id=self._generate_id(),
            placa=dados_veiculo['placa'],
            marca=dados_veiculo['marca'],
            modelo=dados_veiculo['modelo'],
            ano=parsed['ano'],
            quilometragem=parsed['quilometragem'],
            status='disponivel',
            is_disponivel=True,
            preco_diaria=parsed['preco_diaria']
        ) 
        self.model.add(novo_veiculo)
        return novo_veiculo

    def update_vehicle(self, veiculo_id, dados):
        veiculo = self.model.get_by_id(veiculo_id)
        if not veiculo: return None
        parsed = self._parse_vehicle_data(dados)
        veiculo.placa = dados['placa']
        veiculo.marca = dados['marca']
        veiculo.modelo = dados['modelo']
        veiculo.ano = parsed['ano']
        veiculo.quilometragem = parsed['quilometragem']
        veiculo.preco_diaria = parsed['preco_diaria']
        self.model.update(veiculo)
        return veiculo

    def get_by_id(self, veiculo_id):
        return self.model.get_by_id(veiculo_id)

    def get_available(self):
        return [v for v in self.model.get_all() if v.is_disponivel]

    def delete_vehicle(self, veiculo_id):
        self.model.delete(veiculo_id)