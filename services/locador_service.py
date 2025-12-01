from models.locador import Locador, LocadorModel
from models.user import UserModel

class LocadorService:
    def __init__(self):
        self.locador_model = LocadorModel()
        self.user_model = UserModel()

    def get_by_id(self, user_id):
        return self.locador_model.get_by_id(user_id)

    def criar_ou_atualizar(self, user_id, nome, telefone, cnpj):
        if not (cnpj.isdigit() and len(cnpj) == 14):
            raise Exception("CNPJ inválido (14 dígitos).")
        if not (telefone.isdigit() and len(telefone) == 11):
            raise Exception("Telefone inválido.")
        locador = self.locador_model.get_by_id(user_id)
        if locador:
            locador.name = nome
            locador.telephone = telefone
            locador.cnpj = cnpj
            self.locador_model.update(locador)
            return locador
        else:
            user_base = self.user_model.get_by_id(user_id)
            if not user_base: return None
            
            novo_locador = Locador(
                id=user_id,
                name=nome,
                email=user_base.email,
                password=user_base.password,
                telephone=telefone,
                is_locador=True,
                cnpj=cnpj
            )
            self.locador_model.add(novo_locador)
            return novo_locador

    def vincular_veiculo(self, user_id, veiculo_obj):
        locador = self.get_by_id(user_id)
        if locador:
            locador.veiculos.append(veiculo_obj)
            self.locador_model.update(locador)

    def atualizar_veiculo_vinculado(self, user_id, veiculo_atualizado):
        locador = self.get_by_id(user_id)
        if locador:
            for i, v in enumerate(locador.veiculos):
                if v.id == veiculo_atualizado.id:
                    locador.veiculos[i] = veiculo_atualizado
                    break
            self.locador_model.update(locador)

    def desvincular_veiculo(self, user_id, veiculo_id):
        locador = self.get_by_id(user_id)
        if locador:
            locador.veiculos = [v for v in locador.veiculos if v.id != veiculo_id]
            self.locador_model.update(locador)