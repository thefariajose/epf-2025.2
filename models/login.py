class Login: 
    def __init__(self, id, email, password, is_locador):
        self.id = id
        self.email = email
        self.password = password
        self.is_locador = is_locador
    
    def to_dict(self):
        return{
            'id': self.id,
            'email': self.email,
            'password': self.password,
            'is_locador': self.is_locador
        }
        
    @classmethod
    def from_dict(cls, data):
        return cls(**data)
    
class LoginModel:
    FILE_PATH = 'data/login.json'
    
    def __init__(self):
        self.login = self._load()
        
    def _load(self):
        import json, os
        if not os.path.exists(self.FILE_PATH):
            return[]
        with open(self.FILE_PATH, 'r', encoding='utf8') as f:
            return [Login.from_dict(item) for item in json.load(f)]

    def _save(self):
        import json
        with open(self.FILE_PATH, 'w', encoding='utf-8') as f:
            json.dump([a.to_dict() for a in self.login], f, indent=4, ensure_ascii=False)
    
    def get_all(self):
        return self.login
    
    def delete(self, login_id):
        self.login = [a for a in self.login if a.id == login_id]
        self._save()
    
    
    
    