from .basemodel import BaseModel, Base

class User(Base):
    #Constructor
    def __init__(self, id, email, password, is_locador):
        super().__init__(id)
        self.email = email
        self.password = password
        self.is_locador = is_locador

    def to_dict(self):
        return self.__dict__

    @classmethod
    def from_dict(cls, data):
        return cls(**data)

class UserModel(BaseModel):
    def __init__(self):
        super().__init__('users.json', User)
    #pega o usuário pelo email, no lugar do id, importante na mecanica do email
    def get_by_email(self, email):
        self.data = self._load()
        return next((u for u in self.data if u.email == email), None)
