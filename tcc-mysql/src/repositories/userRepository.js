const User = require('../models/User');
const { Op } = require('sequelize');

class UserRepository {
  async create(userData) {
    try {
      return await User.create(userData);
    } catch (error) {
      throw error;
    }
  }

  async findAll(options = {}) {
    try {
      const { limit, offset, order } = options;
      return await User.findAll({
        limit,
        offset,
        order: order || [['createdAt', 'DESC']],
        attributes: { exclude: [] } // Incluir todos os campos
      });
    } catch (error) {
      throw error;
    }
  }

  async findById(id) {
    try {
      return await User.findByPk(id);
    } catch (error) {
      throw error;
    }
  }

  async findByEmail(email) {
    try {
      return await User.findOne({
        where: {
          email: email.toLowerCase().trim()
        }
      });
    } catch (error) {
      throw error;
    }
  }

  async update(id, updateData) {
    try {
      const [updatedRowsCount] = await User.update(updateData, {
        where: { id },
        returning: true
      });
      if (updatedRowsCount === 0) {
        return null;
      }
      // Buscar o registro atualizado
      return await this.findById(id);
    } catch (error) {
      throw error;
    }
  }

  async delete(id) {
    try {
      const deletedRowsCount = await User.destroy({
        where: { id }
      });
      return deletedRowsCount > 0;
    } catch (error) {
      throw error;
    }
  }

  async count(whereCondition = {}) {
    try {
      return await User.count({
        where: whereCondition
      });
    } catch (error) {
      throw error;
    }
  }

  async findAndCountAll(options = {}) {
    try {
      const { limit, offset, where, order } = options;
      return await User.findAndCountAll({
        where,
        limit,
        offset,
        order: order || [['createdAt', 'DESC']]
      });
    } catch (error) {
      throw error;
    }
  }

  async search(searchTerm, options = {}) {
    try {
      const { limit, offset } = options;
      return await User.findAll({
        where: {
          [Op.or]: [
            { name: { [Op.like]: `%${searchTerm}%` } },
            { email: { [Op.like]: `%${searchTerm}%` } }
          ]
        },
        limit,
        offset,
        order: [['createdAt', 'DESC']]
      });
    } catch (error) {
      throw error;
    }
  }
}

module.exports = new UserRepository();
