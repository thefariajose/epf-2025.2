from .basemodel import Base, BaseModel

class Vehicle(Base):
    #Constructor
    def __init__(self, id, placa, marca, modelo, ano, quilometragem, status, is_disponivel, preco_diaria):
        super().__init__(id)
        self.placa = placa
        self.marca = marca
        self.modelo = modelo
        self.ano = ano
        self.quilometragem = quilometragem
        self.status = status
        self.is_disponivel = is_disponivel
        self.preco_diaria = preco_diaria

    def __repr__(self):
        return f"Vehicle({self.placa}, {self.modelo})"
    
    def to_dict(self):
        return self.__dict__
    
    @classmethod
    def from_dict(cls, data):
        return cls(**data)

class VehicleModel(BaseModel):
    def __init__(self):
        super().__init__('vehicles.json', Vehicle)