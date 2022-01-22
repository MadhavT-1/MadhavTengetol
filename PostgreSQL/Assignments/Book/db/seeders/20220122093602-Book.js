'use strict';

module.exports = {
  async up (queryInterface, Sequelize) {
   
      await queryInterface.bulkInsert('Books', [
        {
          bookName: 'The Lord of the Rings',
          author: 'J.R.R. Tolkien',
          publishDate: '1954-07-29',
          createdAt: new Date(),
          updatedAt: new Date()
        },
        {
          bookName: 'The Hobbit',
          author: 'J.R.R. Tolkien',
          publishDate: '1937-09-21',
          createdAt: new Date(),
          updatedAt: new Date()
        },
        {
          bookName: 'The Catcher in the Rye',
          author: 'J.D. Salinger',
          publishDate: '1951-09-21',
          createdAt: new Date(),
          updatedAt: new Date()
        } 
      
      ], {});
    
 
  },

  async down (queryInterface, Sequelize) {
    /**
     * Add commands to revert seed here.
     *
     * Example:
     * await queryInterface.bulkDelete('People', null, {});
     */
  }
};
