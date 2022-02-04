'use strict';

module.exports = {
  async up (queryInterface, Sequelize) {
    /**
     * Add seed commands here.
     *
     * Example:
     * await queryInterface.bulkInsert('People', [{
     *   name: 'John Doe',
     *   isBetaMember: false
     * }], {});
    */
   await queryInterface.bulkInsert('Products',[
    {
      name: "Rose",
      description:
        "Roses are the best conveyor of emotions and are one of the flowers, that would fit the best, to send your message of love for someone, no matter what the situation is.",
      image:
        "https://images.pexels.com/photos/736230/pexels-photo-736230.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500",
      price: "100",
      available_qty: "100",
      createdAt: new Date(),
      updatedAt: new Date(),
    },
    {
      name: "Balloon Flower",
      description:
        "The Balloon Flower also goes by the name Platycodon or the Chinese bellflower. This plant is an herb and perennial with a short flowering period.",
      image:
        "https://www.gardenfactoryny.com/media/catalog/product/cache/b456f9c06a31f834e13ba33f49c2d862/1/3/131693_e8r4M3rbGUYWAvSD.jpg",
      price: "200",
      available_qty: "100",
      createdAt: new Date(),
      updatedAt: new Date(),
    },
    {
      name: "Marigold",
      description:
        "Marigolds have daisy-like or twice, carnation-like flower heads and are produced separately or in clusters. Marigolds come in special colours, yellow and orange being the most common.",
      image:
        "https://image.shutterstock.com/image-photo/floral-arrangement-marigold-flowers-bunch-260nw-1713741913.jpg",
      price: "50",
      available_qty: "1000",
      createdAt: new Date(),
      updatedAt: new Date(),
    },
    {
      name: "Begonia",
      description:
        "The Begonia is a showy flower with fleshy leaves that are green or bronze in color. The flowers come in many colors, and they are considered half-hardy annuals.",
      image:
        "https://th.bing.com/th/id/OIP.QrKBlmr9ckKvTJEFRGmHKAHaHa?pid=ImgDet&rs=1",
      price: "100",
      available_qty: "1000",
      createdAt: new Date(),
      updatedAt: new Date(),
    },
    {
      name: "Bergenia",
      description:
        "Bergenia is also referred to as elephant’s ears. These plants are a great evergreen ground cover and have large, rounded leaves.",
      image:
        "https://th.bing.com/th/id/OIP.i8Xq7vaPEQYbhypa48WQaAHaJ3?pid=ImgDet&rs=1",
      price: "50",
      available_qty: "1000",
      createdAt: new Date(),
      updatedAt: new Date(),
    },
    {
      name: "Calendula",
      description:
        "The Calendula plant is also known as a pot marigold or English marigold. It tends to be fast growing and is a hardy plant but needs full sunlight.",
      image:
        "https://i.etsystatic.com/13582424/r/il/91c4bd/2442185972/il_794xN.2442185972_i44t.jpg",
      price: "50",
      available_qty: "1000",
      createdAt: new Date(),
      updatedAt: new Date(),
    },
    {
      name: "Abutilon",
      description:
        "Abutilon is a shrub that blooms during the summer. This plant produces flowers that may be white to a purple blue color.",
      image:
        "https://www.gardeningknowhow.com/wp-content/uploads/2017/08/abutilon-pruning.jpg",
      price: "310",
      available_qty: "278",
      createdAt: new Date(),
      updatedAt: new Date(),
    },
    {
      name: "Acacia",
      description:
        "Acacias are soft, yellow flowers that tend to be fluffy. These plants are delicate and tender, growing best in sheltered gardens away from the cold frosts of northern climates",
      image: "https://boisdejasmin.com/images/2016/06/white-acacia.jpg",
      price: "210",
      available_qty: "43",
      createdAt: new Date(),
      updatedAt: new Date(),
    },
    {
      name: "Aconite",
      description:
        "Aconite is a poisonous plant that is beautiful, which brings many people to plant it in their gardens. ",
      image:
        "https://thumbs.dreamstime.com/b/yellow-winter-aconite-665504.jpg",
      price: "410",
      available_qty: "124",
      createdAt: new Date(),
      updatedAt: new Date(),
    },
    {
      name: "African Daisy",
      description:
        "The African Daisy is a perennial with flowers that come in a variety of colors including red, gold, and blue.",
      image:
        "https://th.bing.com/th/id/OIP.sIay-RV7hD3I2YXqhO7-AgHaHa?pid=ImgDet&rs=1",
      price: "399",
      available_qty: "321",
      createdAt: new Date(),
      updatedAt: new Date(),
    },
    {
      name: "Agapanthus",
      description:
        "Agapanthus comes in a variety of colors and heights. These showy flowers are produced in colors such as blue and purple.",
      image:
        "https://th.bing.com/th/id/OIP.GencXHx7_ToKknnIIG81ZQHaHa?pid=ImgDet&w=500&h=500&rs=1",
      price: "259",
      available_qty: "435",
      createdAt: new Date(),
      updatedAt: new Date(),
    },
    {
      name: "Alstroemeria",
      description:
        "Alstroemeria is also called the Peruvian lily and is often grown commercially because the cut flowers last a long time.",
      image:
        "https://i.pinimg.com/originals/e8/cc/7b/e8cc7b3a2eb041a840beca36542ecb8c.jpg",
      price: "459",
      available_qty: "435",
      createdAt: new Date(),
      updatedAt: new Date(),
    },
    {
      name: "Camellia",
      description:
        "The Camellia flowers have a characteristic glossy leaf and are classified as  evergreens. These are long-lived plants that typically flower ",
      image:
        "https://www.wallpaperflare.com/static/298/274/467/pink-perfection-japanese-camellia-flower-wallpaper.jpg",
      price: "899",
      available_qty: "212",
      createdAt: new Date(),
      updatedAt: new Date(),
    },
    {
      name: "Cape Leadwort",
      description:
        "Cape Leadwort, which is also called plumbago, is an evergreen climber. The flowers produced are starry, sky blue flowers that it produces between the middle of summer and fall.",
      image:
        "https://www.dearplants.com/wp-content/uploads/2018/10/How-to-plant-Plumbago-auriculata-Cape-leadwort-dearplants.jpg",
      price: "299",
      available_qty: "352",
      createdAt: new Date(),
      updatedAt: new Date(),
    },
    {
      name: "Cerastium Tomentosum",
      description:
        "The Cerastium tomentosumis also known as snow in summer. The plant produces silver-gray leaves, and the plant develops sprays of white flowers.",
      image:
        "https://c.pxhere.com/photos/14/93/flowers_white_white_flowers-620234.jpg!d",
      price: "199",
      available_qty: "564",
      createdAt: new Date(),
      updatedAt: new Date(),
    },
    {
      name: "Chrysanthemum",
      description:
        "Chrysanthemums originated thousands of years ago in China before being brought over to Japan. They are commonly used as a cut flower in arrangements or grown as a border flower.",
      image:
        "https://i.pinimg.com/originals/b2/c3/e2/b2c3e2e5879aa54cf1038b621a07cb20.png",
      price: "249",
      available_qty: "700",
      createdAt: new Date(),
      updatedAt: new Date(),
    },
    {
      name: "Cyclamen",
      description:
        "The Cyclamen is a group of plants that are characterized by having largely marbled foliage. ",
      image:
        "https://th.bing.com/th/id/OIP.sR2at8pkgKkb-FoZZj6tUwHaHa?pid=ImgDet&w=600&h=600&rs=1",
      price: "599",
      available_qty: "500",
      createdAt: new Date(),
      updatedAt: new Date(),
    },
    {
      name: "Dahlia",
      description:
        "The Dahlia is a tuberous perennial flower that is native to Mexico and South America. ",
      image:
        "https://th.bing.com/th/id/OIP.rlN4WFvKMRf3-WtV9LmojgHaE8?pid=ImgDet&rs=1",
      price: "399",
      available_qty: "135",
      createdAt: new Date(),
      updatedAt: new Date(),
    },
    {
      name: "Daylily",
      description:
        "The Daylily is not a true lily. So named because most flowers wither within a day of blooming, these plants belong to the genus Hemerocallis.",
      image:
        "https://i.pinimg.com/originals/42/3a/5a/423a5a3204e0474be1ecd8902ca9241f.jpg",
      price: "199",
      available_qty: "450",
      createdAt: new Date(),
      updatedAt: new Date(),
    },
    {
      name: "Delphinium",
      description:
        "The delphinium is a tall flower, growing around 39 to 78 inches tall. The plants produce spires of long-lasting blooms.",
      image:
        "https://i5.walmartimages.com/asr/209aa558-8fae-42b9-bfb2-8d552b004763_1.569d9abddf57a4f208d30d137ffafb0b.jpeg",
      price: "299",
      available_qty: "870",
      createdAt: new Date(),
      updatedAt: new Date(),
    },
    {
      name: "Disa",
      description:
        "There is only one species of Disa plant commonly cultivated. These have scarlet flowers with a red and gold venation. Under natural circumstances, yellow ones may also be found.",
      image:
        "https://i.pinimg.com/originals/ab/63/cd/ab63cd574ed7f513edf71bd4b94c124e.jpg",
      price: "499",
      available_qty: "369",
      createdAt: new Date(),
      updatedAt: new Date(),
    },
    {
      name: "Fall Crocus",
      description:
        "The Fall Crocus is also known as meadow saffron or Colchicum autumnale. The plant has its flowers emerge directly from the corm, and the leaves don’t appear until later.",
      image:
        "https://th.bing.com/th/id/OIP.otuPPPUzlUO8QOs23Gke_AHaHa?pid=ImgDet&rs=1",
      price: "399",
      available_qty: "789",
      createdAt: new Date(),
      updatedAt: new Date(),
    },
    {
      name: "Four O’clock",
      description:
        "Four O’clock flowers bloom in the late afternoon, are known for being fragrant and bloom in a wide variety of colors such as white, yellow, red and pink. ",
      image:
        "https://i.pinimg.com/736x/86/7f/88/867f8842d7cddeec87bc0d70f5a426e4.jpg",
      price: "159",
      available_qty: "139",
      createdAt: new Date(),
      updatedAt: new Date(),
    },
    {
      name: "Frangipani Flower",
      description:
        "The Frangipani Flower is also known as Plumeria or templetree. This plant is a tree that is a seasonal bloomer, with red and pink blooms.",
      image:
        "https://th.bing.com/th/id/OIP.KJMTgQi114JbVXAYq27nywHaLH?pid=ImgDet&rs=1",
      price: "129",
      available_qty: "980",
      createdAt: new Date(),
      updatedAt: new Date(),
    },
    {
      name: "Fuchsia",
      description:
        "They are seasonal bloomers that do well when planted in full sun to partial shade. Overwintering them can be tricky in cooler climates and requires putting the plant into a dormant period.",
      image:
        "https://www.gardeningknowhow.com/wp-content/uploads/2020/07/hybrid-fuchsia.jpg",
      price: "699",
      available_qty: "890",
      createdAt: new Date(),
      updatedAt: new Date(),
    },
    {
      name: "Gardenia",
      description:
        "These plants are considered a broadleaf evergreen, and they need partial shade. The flowers are prized because they are fragrant and showy, and when cut, they make an excellent cut flower for your display.",
      image:
        "https://th.bing.com/th/id/OIP.rWZaQuj9qfbraUbQLtcK1QHaE7?pid=ImgDet&rs=1",
      price: "359",
      available_qty: "69",
      createdAt: new Date(),
      updatedAt: new Date(),
    },
    {
      name: "Geranium",
      description:
        "Dwarf species may be 6 inches tall, while other geraniums get to be around 39 inches tall. Flowers may develop in a variety of shades, including violet, pink, and rose.",
      image:
        "https://th.bing.com/th/id/OIP.deQyVxREh0Ncm8mAfTM_CAHaHa?pid=ImgDet&rs=1",
      price: "499",
      available_qty: "700",
      createdAt: new Date(),
      updatedAt: new Date(),
    }
   ],{});
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
