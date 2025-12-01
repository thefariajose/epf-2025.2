from models.cliente import Cliente, ClienteModel
from models.user import UserModel

class ClienteService:
    def __init__(self):
        self.cliente_model = ClienteModel()
        self.user_model = UserModel()

    def get_by_id(self, user_id):
        return self.cliente_model.get_by_id(user_id)
    #semelhantemente ao do locador, aqui é a mesma coisa, mas com endereço
    def criar_ou_atualizar(self, user_id, nome, telefone, cpf, endereco):
        if not (cpf.isdigit() and len(cpf) == 11):
            raise Exception("CPF inválido.")
        if not (telefone.isdigit() and len(telefone) == 11):
            raise Exception("Telefone inválido.")
        cliente = self.cliente_model.get_by_id(user_id)
        if cliente:
            cliente.name = nome
            cliente.telephone = telefone
            cliente.cpf = cpf
            cliente.endereco = endereco
            self.cliente_model.update(cliente)
        else:
            user_base = self.user_model.get_by_id(user_id)
            if not user_base: return None
            cliente = Cliente(
                id=user_id,
                name=nome,
                email=user_base.email,
                password=user_base.password,
                telephone=telefone,
                is_locador=False,
                cpf=cpf,
                endereco=endereco
            )
            self.cliente_model.add(cliente)
        return cliente