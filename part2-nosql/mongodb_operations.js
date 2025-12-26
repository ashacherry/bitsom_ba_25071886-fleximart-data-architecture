print("=== SCRIPT STARTED ===");

db = db.getSiblingDB("product_catalog_db");

print("Collections present:");
printjson(db.getCollectionNames());

print("Total products:");
print(db.products.countDocuments());

// OPERATION 2
print("Operation 2: Electronics products priced below 50000");

printjson(
  db.products.find(
    { category: "Electronics", price: { $lt: 50000 } },
    { _id: 0, name: 1, price: 1, stock: 1 }
  ).toArray()
);


// ================================
// OPERATION 3: Review Analysis
// ================================
// Find all products with average rating >= 4.0

print("Operation 3: Products with average rating >= 4.0");

printjson(
  db.products.aggregate([
    { $unwind: "$reviews" },
    {
      $group: {
        _id: "$name",
        average_rating: { $avg: "$reviews.rating" }
      }
    },
    {
      $match: {
        average_rating: { $gte: 4.0 }
      }
    },
    {
      $project: {
        _id: 0,
        product_name: "$_id",
        average_rating: { $round: ["$average_rating", 2] }
      }
    }
  ]).toArray()
);

// ================================
// OPERATION 4: Update Operation
// ================================
// Add a new review to product "ELEC001"

print("Operation 4: Add new review to product ELEC001");

const updateResult = db.products.updateOne(
  { product_id: "ELEC001" },
  {
    $push: {
      reviews: {
        user: "U999",
        rating: 4,
        comment: "Good value",
        date: new Date()
      }
    }
  }
);

print("Update result:");
printjson(updateResult);

// Verify update (optional but good for marks)
print("Updated reviews for ELEC001:");
printjson(
  db.products.find(
    { product_id: "ELEC001" },
    { _id: 0, name: 1, reviews: 1 }
  ).toArray()
);
// ================================
// OPERATION 5: Complex Aggregation
// ================================
// Calculate average price by category

print("Operation 5: Average price by category");

printjson(
  db.products.aggregate([
    {
      $group: {
        _id: "$category",
        avg_price: { $avg: "$price" },
        product_count: { $sum: 1 }
      }
    },
    {
      $project: {
        _id: 0,
        category: "$_id",
        avg_price: { $round: ["$avg_price", 2] },
        product_count: 1
      }
    },
    {
      $sort: { avg_price: -1 }
    }
  ]).toArray()
);


print("=== SCRIPT COMPLETED ===");
