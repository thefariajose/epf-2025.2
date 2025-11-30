from models.locador import Locador, LocadorModel
from models.user import UserModel

class LocadorService:
    def __init__(self):
        self.locador_model = LocadorModel()
        self.user_model = UserModel()

    def get_by_id(self, user_id):
        return self.locador_model.get_by_id(user_id)

    def criar_ou_atualizar(self, user_id, nome, telefone, cnpj):
        user_base = self.user_model.get_by_id(user_id)
        if not user_base: return None

        locador = self.locador_model.get_by_id(user_id)
        
        if locador:
            locador.name = nome
            locador.telephone = telefone
            locador.cnpj = cnpj
            self.locador_model.update_locador(locador)
        else:
            locador = Locador(
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
            self.locador_model.add_locador(locador)
        return locador

    def vincular_veiculo(self, user_id, veiculo_obj):
        """Adiciona o veículo recém criado à lista do locador"""
        locador = self.get_by_id(user_id)
        if locador:
            locador.veiculos.append(veiculo_obj)
            self.locador_model.update_locador(locador)

    def desvincular_veiculo(self, user_id, veiculo_id):
        """Remove o veículo da lista do locador"""
        locador = self.get_by_id(user_id)
        if locador:
            # Reconstrói a lista excluindo o ID alvo
            locador.veiculos = [v for v in locador.veiculos if v.id != veiculo_id]
            self.locador_model.update_locador(locador)