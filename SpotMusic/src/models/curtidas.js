'use strict';
const { Model } = require('sequelize');
module.exports = (sequelize, DataTypes) => {
  class Curtidas extends Model {
    static associate(models) {
      Curtidas.belongsTo(models.Usuario, { foreignKey: 'id_usuario' });
      Curtidas.belongsTo(models.Musica, { foreignKey: 'id_musica' });
    }
  }
  Curtidas.init({
    id_usuario: {
      type: DataTypes.INTEGER,
      primaryKey: true,
      allowNull: false
    },
    id_musica: {
      type: DataTypes.INTEGER,
      primaryKey: true,
      allowNull: false
    },
    data_curtida: DataTypes.DATE
  }, {
    sequelize,
    modelName: 'Curtidas',
    tableName: 'curtidas',
  });
  return Curtidas;
};
