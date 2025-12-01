from models.locador import Locador, LocadorModel
from models.vehicles import Vehicle, VehicleModel
from models.user import UserModel 

class LocadorService:
    def __init__(self):
        self.locador_model = LocadorModel()
        self.vehicle_model = VehicleModel()
        self.user_model = UserModel()

    def get_by_id(self, user_id):
        self.locador_model.locadores = self.locador_model._load()
        return self.locador_model.get_by_id(user_id)

    def criar_ou_atualizar(self, user_id, nome, telefone, cnpj):
        self.user_model.users = self.user_model._load()
        user_base = self.user_model.get_by_id(user_id)
        if not user_base: return None
        #verifica se cnpj tem 14 digitos e são numeros
        if not cnpj.isdigit():
            raise Exception("CNPJ inválido: deve conter dígitos numéricos")
        if len(cnpj) != 14:
            raise Exception("CNPJ inválido: deve conter exatamente 11 dígitos")
        #verifica se telefone tem 11 digitos e são numeros
        if not telefone.isdigit():
            raise Exception("Telefone inválido: deve conter dígitos numéricos")
        if len(telefone) != 11:
            raise Exception("Telefone inválido: deve conter exatamente 11 dígitos")
        self.locador_model.locadores = self.locador_model._load()
        locador_existente = self.locador_model.get_by_id(user_id)
        if locador_existente:
            locador_existente.name = nome
            locador_existente.telephone = telefone
            locador_existente.cnpj = cnpj
            self.locador_model.update_locador(locador_existente)
            return locador_existente
        else:
            novo_locador = Locador(
                id=user_id,
                name=nome,
                email=user_base.email,
                password=user_base.password,
                telephone=telefone,
                is_locador=True,
                cnpj=cnpj,
                veiculos=[],
                historico_locacoes=[]
            )
            self.locador_model.add_locador(novo_locador)
            return novo_locador

    def vincular_veiculo(self, user_id, veiculo_obj):
        self.locador_model.locadores = self.locador_model._load()
        locador = self.get_by_id(user_id)
        
        if locador:
            locador.veiculos.append(veiculo_obj)
            self.locador_model.update_locador(locador)

    def atualizar_veiculo_vinculado(self, user_id, veiculo_atualizado):
        self.locador_model.locadores = self.locador_model._load()
        locador = self.get_by_id(user_id)
        
        if locador:
            for i, v in enumerate(locador.veiculos):
                if v.id == veiculo_atualizado.id:
                    locador.veiculos[i] = veiculo_atualizado
                    break
            self.locador_model.update_locador(locador)

    def desvincular_veiculo(self, user_id, veiculo_id):
        self.locador_model.locadores = self.locador_model._load()
        locador = self.get_by_id(user_id)
        
        if locador:
            locador.veiculos = [v for v in locador.veiculos if v.id != veiculo_id]
            self.locador_model.update_locador(locador)