<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>FoodHub - Food Delivery App</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Inter', -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
        }

        .glass {
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(10px);
            border-radius: 20px;
            box-shadow: 0 8px 32px rgba(0, 0, 0, 0.1);
        }

        .btn-primary {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 12px 24px;
            border-radius: 12px;
            border: none;
            cursor: pointer;
            font-weight: 600;
            transition: all 0.3s;
            box-shadow: 0 4px 15px rgba(102, 126, 234, 0.4);
        }

        .btn-primary:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(102, 126, 234, 0.6);
        }

        .food-card {
            transition: all 0.3s;
            cursor: pointer;
        }

        .food-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.15);
        }

        .cart-badge {
            position: absolute;
            top: -8px;
            right: -8px;
            background: #ef4444;
            color: white;
            border-radius: 50%;
            width: 24px;
            height: 24px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 12px;
            font-weight: bold;
        }

        .fade-in {
            animation: fadeIn 0.5s ease-in;
        }

        @keyframes fadeIn {
            from {
                opacity: 0;
                transform: translateY(20px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        .modal {
            display: none;
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: rgba(0, 0, 0, 0.5);
            z-index: 1000;
            align-items: center;
            justify-content: center;
        }

        .modal.active {
            display: flex;
        }

        .category-btn {
            padding: 10px 20px;
            border-radius: 25px;
            border: 2px solid #e5e7eb;
            background: white;
            cursor: pointer;
            transition: all 0.3s;
            font-weight: 500;
        }

        .category-btn:hover {
            border-color: #667eea;
            color: #667eea;
        }

        .category-btn.active {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            border-color: transparent;
        }

        .input-field {
            width: 100%;
            padding: 12px 16px;
            border: 2px solid #e5e7eb;
            border-radius: 12px;
            font-size: 16px;
            transition: all 0.3s;
        }

        .input-field:focus {
            outline: none;
            border-color: #667eea;
            box-shadow: 0 0 0 3px rgba(102, 126, 234, 0.1);
        }

        .pulse {
            animation: pulse 2s infinite;
        }

        @keyframes pulse {
            0%, 100% {
                opacity: 1;
            }
            50% {
                opacity: 0.5;
            }
        }
    </style>
</head>
<body>
    <!-- Login/Signup Modal -->
    <div id="authModal" class="modal active">
        <div class="glass p-8 max-w-md w-full mx-4 fade-in">
            <div class="text-center mb-6">
                <h1 class="text-4xl font-bold mb-2" style="background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); -webkit-background-clip: text; -webkit-text-fill-color: transparent;">FoodHub</h1>
                <p class="text-gray-600">Your favorite food, delivered fast</p>
            </div>

            <div id="loginForm">
                <h2 class="text-2xl font-bold mb-6 text-gray-800">Welcome Back!</h2>
                <div class="space-y-4">
                    <div>
                        <label class="block text-sm font-medium text-gray-700 mb-2">Email</label>
                        <input type="email" id="loginEmail" class="input-field" placeholder="Enter your email">
                    </div>
                    <div>
                        <label class="block text-sm font-medium text-gray-700 mb-2">Password</label>
                        <input type="password" id="loginPassword" class="input-field" placeholder="Enter your password">
                    </div>
                    <button onclick="login()" class="btn-primary w-full">Login</button>
                    <p class="text-center text-sm text-gray-600">
                        Don't have an account? 
                        <span onclick="toggleAuth()" class="text-purple-600 font-semibold cursor-pointer hover:underline">Sign up</span>
                    </p>
                </div>
            </div>

            <div id="signupForm" style="display: none;">
                <h2 class="text-2xl font-bold mb-6 text-gray-800">Create Account</h2>
                <div class="space-y-4">
                    <div>
                        <label class="block text-sm font-medium text-gray-700 mb-2">Full Name</label>
                        <input type="text" id="signupName" class="input-field" placeholder="Enter your name">
                    </div>
                    <div>
                        <label class="block text-sm font-medium text-gray-700 mb-2">Email</label>
                        <input type="email" id="signupEmail" class="input-field" placeholder="Enter your email">
                    </div>
                    <div>
                        <label class="block text-sm font-medium text-gray-700 mb-2">Password</label>
                        <input type="password" id="signupPassword" class="input-field" placeholder="Create a password">
                    </div>
                    <button onclick="signup()" class="btn-primary w-full">Sign Up</button>
                    <p class="text-center text-sm text-gray-600">
                        Already have an account? 
                        <span onclick="toggleAuth()" class="text-purple-600 font-semibold cursor-pointer hover:underline">Login</span>
                    </p>
                </div>
            </div>
        </div>
    </div>

    <!-- Main App -->
    <div id="mainApp" style="display: none;">
        <!-- Header -->
        <header class="glass mx-4 mt-4 p-4 mb-6">
            <div class="max-w-7xl mx-auto flex justify-between items-center">
                <div>
                    <h1 class="text-2xl font-bold" style="background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); -webkit-background-clip: text; -webkit-text-fill-color: transparent;">FoodHub</h1>
                    <p class="text-sm text-gray-600">Welcome, <span id="userName">User</span>!</p>
                </div>
                <div class="flex items-center gap-4">
                    <div class="relative cursor-pointer" onclick="toggleCart()">
                        <i class="fas fa-shopping-cart text-2xl text-gray-700"></i>
                        <span id="cartCount" class="cart-badge">0</span>
                    </div>
                    <button onclick="logout()" class="text-red-500 font-semibold hover:text-red-600">
                        <i class="fas fa-sign-out-alt mr-2"></i>Logout
                    </button>
                </div>
            </div>
        </header>

        <div class="max-w-7xl mx-auto px-4 pb-8">
            <!-- Search Bar -->
            <div class="glass p-4 mb-6">
                <div class="relative">
                    <i class="fas fa-search absolute left-4 top-1/2 transform -translate-y-1/2 text-gray-400"></i>
                    <input type="text" id="searchInput" onkeyup="searchFood()" class="input-field pl-12" placeholder="Search for food...">
                </div>
            </div>

            <!-- Categories -->
            <div class="glass p-6 mb-6">
                <h2 class="text-xl font-bold mb-4 text-gray-800">Categories</h2>
                <div class="flex gap-3 overflow-x-auto pb-2">
                    <button class="category-btn active" onclick="filterCategory('all')">All</button>
                    <button class="category-btn" onclick="filterCategory('pizza')">🍕 Pizza</button>
                    <button class="category-btn" onclick="filterCategory('burger')">🍔 Burgers</button>
                    <button class="category-btn" onclick="filterCategory('asian')">🍜 Asian</button>
                    <button class="category-btn" onclick="filterCategory('dessert')">🍰 Desserts</button>
                    <button class="category-btn" onclick="filterCategory('drinks')">🥤 Drinks</button>
                </div>
            </div>

            <!-- Food Menu -->
            <div class="glass p-6">
                <h2 class="text-xl font-bold mb-6 text-gray-800">Popular Dishes</h2>
                <div id="foodMenu" class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
                    <!-- Food items will be inserted here -->
                </div>
            </div>
        </div>
    </div>

    <!-- Cart Modal -->
    <div id="cartModal" class="modal">
        <div class="glass p-6 max-w-2xl w-full mx-4 max-h-[90vh] overflow-y-auto">
            <div class="flex justify-between items-center mb-6">
                <h2 class="text-2xl font-bold text-gray-800">Your Cart</h2>
                <button onclick="toggleCart()" class="text-gray-500 hover:text-gray-700">
                    <i class="fas fa-times text-2xl"></i>
                </button>
            </div>
            <div id="cartItems" class="space-y-4 mb-6">
                <!-- Cart items will be inserted here -->
            </div>
            <div class="border-t pt-4">
                <div class="flex justify-between items-center mb-4">
                    <span class="text-lg font-semibold">Total:</span>
                    <span class="text-2xl font-bold" style="color: #667eea;">$<span id="cartTotal">0.00</span></span>
                </div>
                <button onclick="placeOrder()" class="btn-primary w-full text-lg">
                    <i class="fas fa-check-circle mr-2"></i>Place Order
                </button>
            </div>
        </div>
    </div>

    <!-- Order Success Modal -->
    <div id="successModal" class="modal">
        <div class="glass p-8 max-w-md w-full mx-4 text-center">
            <div class="mb-4">
                <i class="fas fa-check-circle text-6xl text-green-500"></i>
            </div>
            <h2 class="text-2xl font-bold mb-2 text-gray-800">Order Placed Successfully!</h2>
            <p class="text-gray-600 mb-6">Your delicious food is on the way!</p>
            <p class="text-sm text-gray-500 mb-6">Order ID: #<span id="orderId"></span></p>
            <button onclick="closeSuccess()" class="btn-primary">Continue Shopping</button>
        </div>
    </div>

    <script>
        // Food Data
        const foodItems = [
            { id: 1, name: 'Margherita Pizza', category: 'pizza', price: 12.99, image: '🍕', description: 'Classic Italian pizza with fresh mozzarella', rating: 4.8 },
            { id: 2, name: 'Pepperoni Pizza', category: 'pizza', price: 14.99, image: '🍕', description: 'Loaded with pepperoni and cheese', rating: 4.9 },
            { id: 3, name: 'Classic Burger', category: 'burger', price: 8.99, image: '🍔', description: 'Juicy beef patty with all the fixings', rating: 4.7 },
            { id: 4, name: 'Cheese Burger', category: 'burger', price: 9.99, image: '🍔', description: 'Double cheese with crispy bacon', rating: 4.8 },
            { id: 5, name: 'Pad Thai', category: 'asian', price: 11.99, image: '🍜', description: 'Traditional Thai noodles', rating: 4.6 },
            { id: 6, name: 'Sushi Roll', category: 'asian', price: 15.99, image: '🍣', description: 'Fresh salmon and avocado roll', rating: 4.9 },
            { id: 7, name: 'Ramen Bowl', category: 'asian', price: 13.99, image: '🍜', description: 'Rich tonkotsu broth with noodles', rating: 4.8 },
            { id: 8, name: 'Chocolate Cake', category: 'dessert', price: 6.99, image: '🍰', description: 'Rich chocolate layer cake', rating: 4.9 },
            { id: 9, name: 'Ice Cream', category: 'dessert', price: 4.99, image: '🍨', description: 'Assorted flavors available', rating: 4.7 },
            { id: 10, name: 'Cola', category: 'drinks', price: 2.99, image: '🥤', description: 'Chilled soft drink', rating: 4.5 },
            { id: 11, name: 'Orange Juice', category: 'drinks', price: 3.99, image: '🧃', description: 'Fresh squeezed orange juice', rating: 4.6 },
            { id: 12, name: 'Iced Coffee', category: 'drinks', price: 4.99, image: '☕', description: 'Cold brew with ice', rating: 4.8 }
        ];

        let cart = [];
        let currentUser = null;
        let currentCategory = 'all';

        // Initialize
        function init() {
            renderFoodItems();
        }

        // Auth Functions
        function toggleAuth() {
            const loginForm = document.getElementById('loginForm');
            const signupForm = document.getElementById('signupForm');
            
            if (loginForm.style.display === 'none') {
                loginForm.style.display = 'block';
                signupForm.style.display = 'none';
            } else {
                loginForm.style.display = 'none';
                signupForm.style.display = 'block';
            }
        }

        function login() {
            const email = document.getElementById('loginEmail').value;
            const password = document.getElementById('loginPassword').value;

            if (email && password) {
                currentUser = { name: email.split('@')[0], email: email };
                document.getElementById('authModal').classList.remove('active');
                document.getElementById('mainApp').style.display = 'block';
                document.getElementById('userName').textContent = currentUser.name;
            } else {
                alert('Please enter email and password');
            }
        }

        function signup() {
            const name = document.getElementById('signupName').value;
            const email = document.getElementById('signupEmail').value;
            const password = document.getElementById('signupPassword').value;

            if (name && email && password) {
                currentUser = { name: name, email: email };
                document.getElementById('authModal').classList.remove('active');
                document.getElementById('mainApp').style.display = 'block';
                document.getElementById('userName').textContent = currentUser.name;
            } else {
                alert('Please fill in all fields');
            }
        }

        function logout() {
            currentUser = null;
            cart = [];
            document.getElementById('mainApp').style.display = 'none';
            document.getElementById('authModal').classList.add('active');
            document.getElementById('loginEmail').value = '';
            document.getElementById('loginPassword').value = '';
        }

        // Render Food Items
        function renderFoodItems() {
            const foodMenu = document.getElementById('foodMenu');
            let items = foodItems;

            if (currentCategory !== 'all') {
                items = foodItems.filter(item => item.category === currentCategory);
            }

            foodMenu.innerHTML = items.map(item => `
                <div class="food-card glass p-4 fade-in" data-name="${item.name.toLowerCase()}" data-category="${item.category}">
                    <div class="text-6xl mb-3 text-center">${item.image}</div>
                    <h3 class="font-bold text-lg mb-2 text-gray-800">${item.name}</h3>
                    <p class="text-sm text-gray-600 mb-3">${item.description}</p>
                    <div class="flex items-center mb-3">
                        <span class="text-yellow-500">★</span>
                        <span class="text-sm text-gray-600 ml-1">${item.rating}</span>
                    </div>
                    <div class="flex justify-between items-center">
                        <span class="text-2xl font-bold" style="color: #667eea;">$${item.price}</span>
                        <button onclick="addToCart(${item.id})" class="btn-primary text-sm">
                            <i class="fas fa-plus mr-1"></i>Add
                        </button>
                    </div>
                </div>
            `).join('');
        }

        // Filter Category
        function filterCategory(category) {
            currentCategory = category;
            
            // Update active button
            const buttons = document.querySelectorAll('.category-btn');
            buttons.forEach(btn => btn.classList.remove('active'));
            event.target.classList.add('active');
            
            renderFoodItems();
        }

        // Search Food
        function searchFood() {
            const searchTerm = document.getElementById('searchInput').value.toLowerCase();
            const foodCards = document.querySelectorAll('.food-card');
            
            foodCards.forEach(card => {
                const name = card.getAttribute('data-name');
                if (name.includes(searchTerm)) {
                    card.style.display = 'block';
                } else {
                    card.style.display = 'none';
                }
            });
        }

        // Add to Cart
        function addToCart(itemId) {
            const item = foodItems.find(f => f.id === itemId);
            const existingItem = cart.find(c => c.id === itemId);

            if (existingItem) {
                existingItem.quantity++;
            } else {
                cart.push({ ...item, quantity: 1 });
            }

            updateCartCount();
            showNotification('Added to cart!');
        }

        // Update Cart Count
        function updateCartCount() {
            const count = cart.reduce((sum, item) => sum + item.quantity, 0);
            document.getElementById('cartCount').textContent = count;
        }

        // Toggle Cart
        function toggleCart() {
            const cartModal = document.getElementById('cartModal');
            cartModal.classList.toggle('active');
            
            if (cartModal.classList.contains('active')) {
                renderCart();
            }
        }

        // Render Cart
        function renderCart() {
            const cartItems = document.getElementById('cartItems');
            const cartTotal = document.getElementById('cartTotal');

            if (cart.length === 0) {
                cartItems.innerHTML = '<p class="text-center text-gray-500 py-8">Your cart is empty</p>';
                cartTotal.textContent = '0.00';
                return;
            }

            cartItems.innerHTML = cart.map(item => `
                <div class="flex items-center gap-4 glass p-4">
                    <div class="text-4xl">${item.image}</div>
                    <div class="flex-1">
                        <h4 class="font-semibold text-gray-800">${item.name}</h4>
                        <p class="text-sm text-gray-600">$${item.price}</p>
                    </div>
                    <div class="flex items-center gap-3">
                        <button onclick="updateQuantity(${item.id}, -1)" class="w-8 h-8 rounded-full bg-gray-200 hover:bg-gray-300">-</button>
                        <span class="font-semibold w-8 text-center">${item.quantity}</span>
                        <button onclick="updateQuantity(${item.id}, 1)" class="w-8 h-8 rounded-full bg-purple-500 text-white hover:bg-purple-600">+</button>
                    </div>
                    <div class="font-bold" style="color: #667eea;">$${(item.price * item.quantity).toFixed(2)}</div>
                    <button onclick="removeFromCart(${item.id})" class="text-red-500 hover:text-red-600">
                        <i class="fas fa-trash"></i>
                    </button>
                </div>
            `).join('');

            const total = cart.reduce((sum, item) => sum + (item.price * item.quantity), 0);
            cartTotal.textContent = total.toFixed(2);
        }

        // Update Quantity
        function updateQuantity(itemId, change) {
            const item = cart.find(c => c.id === itemId);
            if (item) {
                item.quantity += change;
                if (item.quantity <= 0) {
                    removeFromCart(itemId);
                } else {
                    renderCart();
                    updateCartCount();
                }
            }
        }

        // Remove from Cart
        function removeFromCart(itemId) {
            cart = cart.filter(item => item.id !== itemId);
            renderCart();
            updateCartCount();
        }

        // Place Order
        function placeOrder() {
            if (cart.length === 0) {
                alert('Your cart is empty!');
                return;
            }

            const orderId = Math.floor(Math.random() * 1000000);
            document.getElementById('orderId').textContent = orderId;
            
            document.getElementById('cartModal').classList.remove('active');
            document.getElementById('successModal').classList.add('active');
            
            cart = [];
            updateCartCount();
        }

        // Close Success Modal
        function closeSuccess() {
            document.getElementById('successModal').classList.remove('active');
        }

        // Show Notification
        function showNotification(message) {
            const notification = document.createElement('div');
            notification.className = 'fixed top-4 right-4 glass p-4 z-50 fade-in';
            notification.innerHTML = `
                <div class="flex items-center gap-2">
                    <i class="fas fa-check-circle text-green-500"></i>
                    <span class="font-semibold">${message}</span>
                </div>
            `;
            document.body.appendChild(notification);
            
            setTimeout(() => {
                notification.remove();
            }, 2000);
        }

        // Initialize app
        init();
    </script>
</body>
</html>
