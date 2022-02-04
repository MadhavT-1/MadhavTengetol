'use strict';
const {
  Model
} = require('sequelize');
module.exports = (sequelize, DataTypes) => {
  class OrderDetails extends Model {
    /**
     * Helper method for defining associations.
     * This method is not a part of Sequelize lifecycle.
     * The `models/index` file will call this method automatically.
     */
    static associate(models) {
      // define association here
    }
  }
  OrderDetails.init({
    userid: DataTypes.INTEGER,
    productid: DataTypes.INTEGER,
    productname: DataTypes.STRING,
    quantity: DataTypes.INTEGER,
    price: DataTypes.NUMERIC,
    total: DataTypes.NUMERIC,
    orderdate: DataTypes.DATE
  }, {
    sequelize,
    modelName: 'OrderDetails',
  });
  return OrderDetails;
};