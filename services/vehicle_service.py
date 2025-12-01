from models.vehicles import Vehicle, VehicleModel

class VehicleService:
    def __init__(self):
        self.model = VehicleModel()

    def _gerar_id(self):
        self.model.vehicles = self.model._load()
        todos = self.model.get_all()
        if not todos: return 1
        return max([v.id for v in todos]) + 1

    def create_vehicle(self, dados_veiculo):
        novo_id = self._gerar_id()
        try:
            #tenta converter o ano para inteiro
            ano_val = int(dados_veiculo['ano'])
            #tenta converter a quilometragem e preço para float
            km_val = float(dados_veiculo.get('quilometragem', 0))
            preco_val = float(dados_veiculo['preco_diaria'])
        except ValueError:
            raise Exception("Dados inválidos: 'Ano' deve ser inteiro. 'Quilometragem' e 'Preço' devem ser números (use ponto para decimais).")
        novo_veiculo = Vehicle(
            id=novo_id,
            placa=dados_veiculo['placa'],
            marca=dados_veiculo['marca'],
            modelo=dados_veiculo['modelo'],
            ano=ano_val,
            quilometragem=km_val,
            status='disponivel',
            is_disponivel=True,
            preco_diaria=preco_val
        ) 
        self.model.add(novo_veiculo)
        return novo_veiculo

    def update_vehicle(self, veiculo_id, dados):
        self.model.vehicles = self.model._load()
        veiculo = self.model.get_by_id(veiculo_id)
        if veiculo:
            #mesmas exceções de antes
            try:
                ano_val = int(dados['ano'])
                km_val = float(dados['quilometragem'])
                preco_val = float(dados['preco_diaria'])
            except ValueError:
                raise Exception("Dados inválidos: 'Ano' deve ser inteiro. 'Quilometragem' e 'Preço' devem ser números.")
            veiculo.placa = dados['placa']
            veiculo.marca = dados['marca']
            veiculo.modelo = dados['modelo']
            veiculo.ano = ano_val
            veiculo.quilometragem = km_val
            veiculo.preco_diaria = preco_val
            self.model.update(veiculo)
            return veiculo
        return None

    def get_by_id(self, veiculo_id):
        self.model.vehicles = self.model._load()
        return self.model.get_by_id(veiculo_id)

    def get_available(self):
        self.model.vehicles = self.model._load() 
        return [v for v in self.model.get_all() if v.is_disponivel]#avançado

    def delete_vehicle(self, veiculo_id):
        self.model.delete(veiculo_id)