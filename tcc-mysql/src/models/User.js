const { DataTypes } = require('sequelize');
const { sequelize } = require('../config/database');

const User = sequelize.define('User', {
  id: {
    type: DataTypes.INTEGER,
    primaryKey: true,
    autoIncrement: true
  },
  name: {
    type: DataTypes.STRING(50),
    allowNull: false,
    validate: {
      notEmpty: {
        msg: 'Nome é obrigatório'
      },
      len: {
        args: [2, 50],
        msg: 'Nome deve ter entre 2 e 50 caracteres'
      }
    }
  },
  email: {
    type: DataTypes.STRING(100),
    allowNull: false,
    unique: {
      name: 'unique_email',
      msg: 'Email já está em uso'
    },
    validate: {
      notEmpty: {
        msg: 'Email é obrigatório'
      },
      isEmail: {
        msg: 'Email deve ser válido'
      }
    },
    set(value) {
      // Converter para lowercase antes de salvar
      this.setDataValue('email', value.toLowerCase().trim());
    }
  }
}, {
  tableName: 'users',
  timestamps: true, // Adiciona createdAt e updatedAt
  indexes: [
    {
      unique: true,
      fields: ['email']
    }
  ]
});

module.exports = User;
