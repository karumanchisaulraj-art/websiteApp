<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Feastly • Delivery</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600&amp;family=Playfair+Display:wght@700&amp;display=swap');
        
        :root {
            --primary: 249 115 22;
        }
        
        .tail-container {
            font-family: 'Inter', system_ui, sans-serif;
        }
        
        .logo-font {
            font-family: 'Playfair Display', sans-serif;
        }

        .hero-bg {
            background: linear-gradient(90deg, #f97316 0%, #ea580c 100%);
        }

        .card-hover {
            transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
        }
        
        .card-hover:hover {
            transform: translateY(-8px);
            box-shadow: 0 20px 25px -5px rgb(0 0 0 / 0.1), 0 8px 10px -6px rgb(0 0 0 / 0.1);
        }

        .menu-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(260px, 1fr));
            gap: 24px;
        }

        .nav-link {
            position: relative;
        }
        
        .nav-link:after {
            content: '';
            position: absolute;
            width: 0;
            height: 2px;
            bottom: -2px;
            left: 0;
            background-color: rgb(249 115 22);
            transition: all 0.3s ease;
        }
        
        .nav-link:hover:after {
            width: 100%;
        }

        .cart-drawer {
            transition: transform 0.4s cubic-bezier(0.32, 0.72, 0, 1);
        }

        .food-item {
            transition: all 0.2s ease;
        }

        .toast {
            animation: toastIn 0.3s ease forwards;
        }

        @keyframes toastIn {
            from {
                transform: translateY(20px);
                opacity: 0;
            }
            to {
                transform: translateY(0);
                opacity: 1;
            }
        }

        .category-pill {
            transition: all 0.2s ease;
        }
        
        .category-pill.active {
            background-color: rgb(249 115 22);
            color: white;
            transform: scale(1.05);
        }

        .header {
            backdrop-filter: blur(12px);
        }
    </style>
</head>
<body class="tail-container bg-zinc-950 text-zinc-200">
    <div class="flex h-screen overflow-hidden">
        <!-- SIDEBAR -->
        <div class="hidden lg:flex w-72 bg-zinc-900 border-r border-zinc-800 flex-col">
            <!-- logo -->
            <div class="px-8 py-8 border-b border-zinc-800 flex items-center gap-x-3">
                <div class="w-11 h-11 bg-orange-500 rounded-2xl flex items-center justify-center text-3xl shadow-inner">
                    🍔
                </div>
                <div>
                    <span class="logo-font text-4xl font-bold tracking-tighter text-white">feastly</span>
                </div>
            </div>
            
            <!-- nav -->
            <div class="px-3 py-6 flex-1 overflow-y-auto">
                <div onclick="navigateTo('home')" 
                     class="nav-item flex items-center gap-x-3 px-6 py-4 text-zinc-400 hover:text-white hover:bg-zinc-800 rounded-3xl cursor-pointer active-nav">
                    <i class="fa-solid fa-house w-5"></i>
                    <span class="font-medium">Discover</span>
                </div>
                <div onclick="navigateTo('menu')" 
                     class="nav-item flex items-center gap-x-3 px-6 py-4 text-zinc-400 hover:text-white hover:bg-zinc-800 rounded-3xl cursor-pointer mt-1">
                    <i class="fa-solid fa-utensils w-5"></i>
                    <span class="font-medium">Menu</span>
                </div>
                <div onclick="navigateTo('orders')" 
                     class="nav-item flex items-center gap-x-3 px-6 py-4 text-zinc-400 hover:text-white hover:bg-zinc-800 rounded-3xl cursor-pointer mt-1">
                    <i class="fa-solid fa-receipt w-5"></i>
                    <span class="font-medium">Orders</span>
                </div>
                <div onclick="navigateTo('favorites')" 
                     class="nav-item flex items-center gap-x-3 px-6 py-4 text-zinc-400 hover:text-white hover:bg-zinc-800 rounded-3xl cursor-pointer mt-1">
                    <i class="fa-solid fa-heart w-5"></i>
                    <span class="font-medium">Favorites</span>
                </div>
                
                <div class="mt-10 px-6">
                    <p class="text-xs uppercase tracking-widest text-zinc-500 font-medium mb-4">Cuisines</p>
                    <div id="sidebar-categories" class="space-y-1 text-sm"></div>
                </div>
            </div>
            
            <!-- location -->
            <div class="p-6 border-t border-zinc-800">
                <div class="flex items-center gap-x-3 bg-zinc-800 rounded-3xl p-4">
                    <i class="fa-solid fa-location-dot text-orange-400"></i>
                    <div class="text-sm">
                        <div class="font-medium text-white">123 Maple Street</div>
                        <div class="text-zinc-400 text-xs">Downtown • 12 min away</div>
                    </div>
                </div>
            </div>
            
            <!-- user -->
            <div id="sidebar-user" class="p-4 border-t border-zinc-800 flex items-center gap-x-3 cursor-pointer"
                 onclick="showProfileModal()">
                <div class="w-9 h-9 bg-zinc-700 rounded-2xl flex items-center justify-center text-lg">
                    👤
                </div>
                <div class="flex-1">
                    <div id="sidebar-username" class="font-semibold text-sm">Guest User</div>
                    <div class="text-xs text-emerald-400">Online</div>
                </div>
                <button onclick="event.stopImmediatePropagation(); logout()" 
                        class="text-xs bg-zinc-800 hover:bg-red-500/10 hover:text-red-400 px-3 py-1 rounded-2xl transition-colors">
                    <i class="fa-solid fa-right-from-bracket"></i>
                </button>
            </div>
        </div>
        
        <!-- MAIN CONTENT -->
        <div class="flex-1 flex flex-col">
            <!-- top header -->
            <header class="header bg-zinc-900 border-b border-zinc-800 px-6 py-5 flex items-center justify-between sticky top-0 z-50">
                <div class="flex items-center gap-x-6 flex-1">
                    <!-- mobile menu -->
                    <button onclick="toggleMobileMenu()" 
                            class="lg:hidden w-10 h-10 flex items-center justify-center text-2xl text-zinc-400 hover:text-white">
                        <i class="fa-solid fa-bars"></i>
                    </button>
                    
                    <div class="relative flex-1 max-w-md">
                        <input id="search-input" 
                               onkeyup="if(event.key === 'Enter') performSearch()"
                               type="text" 
                               placeholder="Search burgers, sushi, pizza..." 
                               class="w-full bg-zinc-800 border border-zinc-700 focus:border-orange-400 rounded-3xl py-3 px-5 pl-12 text-sm outline-none transition-all">
                        <div class="absolute left-5 top-1/2 -translate-y-1/2 text-zinc-400">
                            <i class="fa-solid fa-magnifying-glass"></i>
                        </div>
                    </div>
                </div>
                
                <div class="flex items-center gap-x-8">
                    <!-- delivery info -->
                    <div class="hidden md:flex items-center gap-x-2 text-xs">
                        <div class="px-3 py-1 bg-emerald-900 text-emerald-300 rounded-3xl flex items-center gap-x-1">
                            <div class="w-2 h-2 bg-emerald-400 rounded-full animate-pulse"></div>
                            <span class="font-medium">25 min</span>
                        </div>
                    </div>
                    
                    <!-- cart button -->
                    <button onclick="toggleCart()" 
                            class="relative flex items-center gap-x-2 bg-zinc-800 hover:bg-zinc-700 transition-colors px-5 h-11 rounded-3xl">
                        <i class="fa-solid fa-bag-shopping text-xl"></i>
                        <span class="font-medium text-sm hidden sm:block">Cart</span>
                        <span id="cart-count-top" 
                              class="absolute -top-1 -right-1 bg-orange-500 text-white text-[10px] font-mono w-5 h-5 flex items-center justify-center rounded-full shadow">
                            0
                        </span>
                    </button>
                    
                    <!-- avatar -->
                    <div onclick="showProfileModal()" 
                         class="w-8 h-8 bg-orange-200 text-orange-800 rounded-2xl flex items-center justify-center font-semibold cursor-pointer text-sm ring-2 ring-orange-400">
                        A
                    </div>
                </div>
            </header>
            
            <!-- CONTENT AREA -->
            <div class="flex-1 overflow-auto p-6 lg:p-8" id="main-content">
                <!-- HOME VIEW -->
                <div id="view-home">
                    <!-- hero -->
                    <div class="hero-bg rounded-3xl h-80 flex items-center px-10 md:px-16 relative overflow-hidden">
                        <div class="max-w-md z-10">
                            <div class="inline-flex items-center gap-x-2 bg-white/20 backdrop-blur-md text-white text-xs px-4 h-7 rounded-3xl mb-6">
                                <span class="relative flex h-3 w-3">
                                    <span class="animate-ping absolute inline-flex h-full w-full rounded-full bg-white opacity-75"></span>
                                    <span class="relative inline-flex rounded-full h-3 w-3 bg-white"></span>
                                </span>
                                250+ restaurants near you
                            </div>
                            <h1 class="text-5xl md:text-6xl font-bold text-white leading-none tracking-tighter logo-font">
                                Craving something<br>delicious?
                            </h1>
                            <p class="text-orange-100 mt-6 text-lg">Order from the best local kitchens and get it delivered in minutes.</p>
                            
                            <div class="mt-10 flex items-center gap-x-4">
                                <button onclick="navigateTo('menu')" 
                                        class="bg-white text-orange-600 px-8 py-4 rounded-3xl font-semibold flex items-center gap-x-2 hover:scale-105 transition-transform">
                                    <span>Browse menu</span>
                                    <i class="fa-solid fa-arrow-right"></i>
                                </button>
                                <button onclick="showRandomItem()" 
                                        class="border border-white/60 text-white px-6 py-4 rounded-3xl font-medium hover:bg-white/10 transition-colors">
                                    Surprise me
                                </button>
                            </div>
                        </div>
                        
                        <!-- floating food images -->
                        <div class="hidden xl:block absolute bottom-6 right-12">
                            <div class="flex gap-6">
                                <div class="w-28 h-28 bg-white rounded-3xl shadow-2xl p-2 rotate-6">
                                    <img src="https://picsum.photos/id/201/300/300" alt="" 
                                         class="w-full h-full object-cover rounded-2xl">
                                </div>
                                <div class="w-28 h-28 bg-white rounded-3xl shadow-2xl p-2 -rotate-6 mt-8">
                                    <img src="https://picsum.photos/id/292/300/300" alt="" 
                                         class="w-full h-full object-cover rounded-2xl">
                                </div>
                            </div>
                        </div>
                        
                        <div class="absolute -bottom-12 -right-12 text-[180px] opacity-10 pointer-events-none">🍕</div>
                    </div>
                    
                    <!-- categories -->
                    <div class="mt-12">
                        <div class="flex items-center justify-between mb-6">
                            <h2 class="text-2xl font-semibold">Categories</h2>
                            <button onclick="navigateTo('menu')" 
                                    class="text-orange-400 text-sm flex items-center gap-x-1 hover:underline">
                                See all <i class="fa-solid fa-chevron-right text-xs"></i>
                            </button>
                        </div>
                        
                        <div id="home-categories" class="grid grid-cols-3 sm:grid-cols-4 md:grid-cols-6 gap-4"></div>
                    </div>
                    
                    <!-- popular near you -->
                    <div class="mt-16">
                        <div class="flex items-center justify-between mb-6">
                            <h2 class="text-2xl font-semibold">Popular near you</h2>
                            <div class="text-zinc-400 text-sm flex items-center">
                                📍 Downtown • 
                                <span class="ml-1 text-emerald-400">15 restaurants</span>
                            </div>
                        </div>
                        
                        <div id="popular-grid" class="menu-grid"></div>
                    </div>
                </div>
                
                <!-- MENU VIEW -->
                <div id="view-menu" class="hidden">
                    <div class="flex items-center justify-between">
                        <h1 class="text-3xl font-semibold">All Menu Items</h1>
                        
                        <div class="flex items-center gap-x-2">
                            <select id="sort-select" onchange="filterMenu()" 
                                    class="bg-zinc-900 border border-zinc-700 rounded-3xl px-5 py-2 text-sm focus:outline-none">
                                <option value="popular">Most popular</option>
                                <option value="price-low">Price: Low to High</option>
                                <option value="price-high">Price: High to Low</option>
                            </select>
                        </div>
                    </div>
                    
                    <!-- category pills -->
                    <div id="menu-category-pills" class="flex gap-2 mt-8 overflow-x-auto pb-6"></div>
                    
                    <div id="full-menu-grid" class="menu-grid"></div>
                </div>
                
                <!-- ORDERS VIEW -->
                <div id="view-orders" class="hidden">
                    <h1 class="text-3xl font-semibold mb-8">Your Orders</h1>
                    
                    <div class="space-y-6">
                        <!-- order 1 -->
                        <div class="bg-zinc-900 rounded-3xl p-6 flex gap-6">
                            <div class="w-24 h-24 bg-zinc-800 rounded-2xl overflow-hidden flex-shrink-0">
                                <img src="https://picsum.photos/id/201/300/300" alt="" class="w-full h-full object-cover">
                            </div>
                            <div class="flex-1">
                                <div class="flex justify-between">
                                    <div>
                                        <div class="font-semibold">Margherita Feast</div>
                                        <div class="text-zinc-400 text-sm">Bella Pasta • 2 items</div>
                                    </div>
                                    <div class="text-right">
                                        <div class="text-emerald-400 font-medium">$24.50</div>
                                        <div class="text-xs text-zinc-500">Delivered 2h ago</div>
                                    </div>
                                </div>
                                <div class="mt-6 flex items-center gap-4 text-xs">
                                    <div class="px-6 py-2 bg-zinc-800 rounded-3xl">Rate order</div>
                                    <div class="px-6 py-2 border border-zinc-700 rounded-3xl">Reorder</div>
                                </div>
                            </div>
                        </div>
                        
                        <!-- order 2 -->
                        <div class="bg-zinc-900 rounded-3xl p-6 flex gap-6 opacity-75">
                            <div class="w-24 h-24 bg-zinc-800 rounded-2xl overflow-hidden flex-shrink-0">
                                <img src="https://picsum.photos/id/292/300/300" alt="" class="w-full h-full object-cover">
                            </div>
                            <div class="flex-1">
                                <div class="flex justify-between">
                                    <div>
                                        <div class="font-semibold">Spicy Dragon Roll</div>
                                        <div class="text-zinc-400 text-sm">Tokyo Sushi • 3 items</div>
                                    </div>
                                    <div class="text-right">
                                        <div class="text-emerald-400 font-medium">$31.80</div>
                                        <div class="text-xs text-zinc-500">Delivered yesterday</div>
                                    </div>
                                </div>
                                <div class="mt-8 text-xs text-orange-400 flex items-center gap-2">
                                    <i class="fa-solid fa-star"></i>
                                    <span>4.9 • You loved this</span>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                
                <!-- FAVORITES VIEW -->
                <div id="view-favorites" class="hidden">
                    <h1 class="text-3xl font-semibold mb-8">Favorites</h1>
                    <div id="favorites-grid" class="menu-grid"></div>
                </div>
            </div>
            
            <!-- MOBILE BOTTOM NAV -->
            <div class="lg:hidden fixed bottom-0 left-0 right-0 bg-zinc-900 border-t border-zinc-700 z-50">
                <div class="flex items-center justify-around py-2 text-xs">
                    <button onclick="navigateTo('home')" class="flex flex-col items-center gap-y-1 text-orange-400">
                        <i class="fa-solid fa-house text-lg"></i>
                        <span>Home</span>
                    </button>
                    <button onclick="navigateTo('menu')" class="flex flex-col items-center gap-y-1 text-zinc-400">
                        <i class="fa-solid fa-utensils text-lg"></i>
                        <span>Menu</span>
                    </button>
                    <button onclick="toggleCart()" class="flex flex-col items-center gap-y-1 text-zinc-400 relative -mt-8">
                        <div class="w-14 h-14 bg-orange-500 rounded-3xl flex items-center justify-center shadow-2xl shadow-orange-600/40">
                            <i class="fa-solid fa-bag-shopping text-3xl"></i>
                        </div>
                    </button>
                    <button onclick="navigateTo('orders')" class="flex flex-col items-center gap-y-1 text-zinc-400">
                        <i class="fa-solid fa-receipt text-lg"></i>
                        <span>Orders</span>
                    </button>
                    <button onclick="showProfileModal()" class="flex flex-col items-center gap-y-1 text-zinc-400">
                        <i class="fa-solid fa-user text-lg"></i>
                        <span>Me</span>
                    </button>
                </div>
            </div>
        </div>
        
        <!-- RIGHT PANEL / CART DRAWER -->
        <div id="cart-panel" 
             class="cart-drawer w-full md:w-96 bg-zinc-900 border-l border-zinc-700 h-full fixed md:relative right-0 top-0 translate-x-full md:translate-x-0 flex flex-col shadow-2xl z-50">
            
            <!-- cart header -->
            <div class="p-6 border-b border-zinc-700 flex justify-between items-center">
                <div class="font-semibold text-xl flex items-center gap-x-2">
                    <i class="fa-solid fa-bag-shopping"></i>
                    <span>Your cart</span>
                </div>
                <button onclick="toggleCart()" class="text-zinc-400 hover:text-white">
                    <i class="fa-solid fa-xmark text-2xl"></i>
                </button>
            </div>
            
            <!-- cart items -->
            <div id="cart-items" class="flex-1 overflow-auto p-6 space-y-8"></div>
            
            <!-- cart footer -->
            <div class="p-6 border-t border-zinc-700">
                <div class="flex justify-between text-sm mb-2">
                    <div class="text-zinc-400">Subtotal</div>
                    <div id="cart-subtotal" class="font-medium">$0.00</div>
                </div>
                <div class="flex justify-between text-sm mb-2">
                    <div class="text-zinc-400">Delivery fee</div>
                    <div class="font-medium text-emerald-400">$3.99</div>
                </div>
                <div class="flex justify-between text-sm">
                    <div class="text-zinc-400">Service fee</div>
                    <div class="font-medium">$1.49</div>
                </div>
                
                <div class="h-px bg-zinc-700 my-6"></div>
                
                <div class="flex justify-between items-center">
                    <div class="font-semibold">Total</div>
                    <div id="cart-total" class="text-3xl font-bold text-white">$0.00</div>
                </div>
                
                <button onclick="checkout()" 
                        class="mt-8 w-full bg-gradient-to-r from-orange-500 to-amber-500 h-14 rounded-3xl text-white font-semibold text-lg shadow-inner flex items-center justify-center gap-x-2 active:scale-95 transition-all">
                    <span>Place order • </span>
                    <span id="cart-total-small">$0</span>
                </button>
                
                <div class="text-center text-[10px] text-zinc-500 mt-6">Est. delivery: 25-35 minutes</div>
            </div>
        </div>
    </div>
    
    <!-- ITEM DETAIL MODAL -->
    <div id="item-modal" class="hidden fixed inset-0 bg-black/70 flex items-center justify-center z-[999]">
        <div onclick="event.stopImmediatePropagation()" 
             class="bg-zinc-900 max-w-lg w-full mx-4 rounded-3xl overflow-hidden">
            
            <!-- image -->
            <div id="modal-image" class="h-64 bg-cover bg-center relative">
                <button onclick="closeItemModal()" 
                        class="absolute top-6 right-6 w-8 h-8 bg-black/60 hover:bg-black/80 text-white rounded-full flex items-center justify-center">
                    ✕
                </button>
            </div>
            
            <div class="p-6">
                <div class="flex justify-between items-start">
                    <div>
                        <div id="modal-name" class="text-2xl font-semibold"></div>
                        <div id="modal-category" class="text-xs uppercase tracking-widest text-orange-400 mt-1"></div>
                    </div>
                    <div id="modal-price" class="text-3xl font-bold text-white"></div>
                </div>
                
                <div id="modal-desc" class="text-zinc-400 mt-6 text-[15px] leading-relaxed"></div>
                
                <div class="flex items-center gap-x-6 mt-8 text-sm">
                    <div class="flex items-center">
                        <i class="fa-solid fa-star text-yellow-400"></i>
                        <span id="modal-rating" class="ml-1 font-medium">4.8</span>
                    </div>
                    <div class="text-zinc-400">•</div>
                    <div id="modal-calories" class="text-zinc-400">620 cal</div>
                </div>
                
                <div class="mt-10 flex items-center gap-3">
                    <button onclick="addCurrentToCart()" 
                            class="flex-1 py-6 bg-orange-500 hover:bg-orange-600 transition-colors text-white rounded-3xl font-semibold text-lg">
                        Add to cart - $<span id="modal-price-bottom">0</span>
                    </button>
                </div>
            </div>
        </div>
    </div>
    
    <!-- LOGIN MODAL -->
    <div id="login-modal" onclick="if(event.target === this) closeLoginModal()" 
         class="hidden fixed inset-0 bg-black/70 flex items-center justify-center z-[999]">
        <div onclick="event.stopImmediatePropagation()" 
             class="bg-zinc-900 w-full max-w-md mx-4 rounded-3xl">
            
            <div class="px-8 pt-8">
                <div class="flex justify-center">
                    <div class="w-16 h-16 bg-orange-500/10 text-orange-400 rounded-3xl flex items-center justify-center text-4xl">
                        🍔
                    </div>
                </div>
                <h2 class="text-center text-3xl font-semibold mt-6">Welcome back</h2>
                <p class="text-center text-zinc-400 text-sm mt-2">Sign in to continue ordering</p>
            </div>
            
            <div class="p-8">
                <div class="space-y-5">
                    <div>
                        <label class="text-xs text-zinc-400 block mb-2">EMAIL ADDRESS</label>
                        <input id="login-email" type="email" value="demo@feastly.com" 
                               class="w-full bg-zinc-800 border border-transparent focus:border-orange-400 rounded-3xl px-6 py-5 outline-none text-sm">
                    </div>
                    <div>
                        <label class="text-xs text-zinc-400 block mb-2">PASSWORD</label>
                        <input id="login-password" type="password" value="demo123" 
                               class="w-full bg-zinc-800 border border-transparent focus:border-orange-400 rounded-3xl px-6 py-5 outline-none text-sm">
                    </div>
                </div>
                
                <div onclick="performLogin()" 
                     class="mt-8 bg-white text-zinc-900 h-14 flex items-center justify-center rounded-3xl font-semibold cursor-pointer active:scale-95 transition-transform">
                    SIGN IN
                </div>
                
                <div class="flex items-center justify-center gap-x-4 my-8">
                    <div class="h-px flex-1 bg-zinc-700"></div>
                    <div class="text-xs text-zinc-500">OR</div>
                    <div class="h-px flex-1 bg-zinc-700"></div>
                </div>
                
                <button onclick="fakeGoogleLogin()" 
                        class="w-full border border-zinc-700 hover:border-zinc-400 transition-colors h-14 rounded-3xl flex items-center justify-center gap-x-3 text-sm">
                    <i class="fa-brands fa-google"></i>
                    <span>Continue with Google</span>
                </button>
            </div>
            
            <div class="text-center py-6 border-t border-zinc-800 text-xs text-zinc-400">
                Don't have an account? 
                <span onclick="fakeRegister()" class="text-orange-400 cursor-pointer">Sign up free</span>
            </div>
        </div>
    </div>
    
    <!-- SUCCESS MODAL -->
    <div id="success-modal" onclick="if(event.target === this) hideSuccessModal()" 
         class="hidden fixed inset-0 bg-black/70 flex items-center justify-center z-[999]">
        <div onclick="event.stopImmediatePropagation()" 
             class="bg-zinc-900 rounded-3xl max-w-sm w-full mx-4 p-8 text-center">
            <div class="w-20 h-20 mx-auto bg-emerald-400/10 rounded-full flex items-center justify-center text-5xl mb-6">
                🎉
            </div>
            <h3 class="text-2xl font-semibold">Order placed!</h3>
            <p class="text-zinc-400 mt-3">Your delicious food is being prepared. We'll notify you when it's on the way.</p>
            
            <div class="my-12 bg-zinc-800 rounded-3xl p-6 text-left text-sm">
                <div class="flex justify-between">
                    <span class="text-zinc-400">Order #FD-48392</span>
                    <span class="font-medium">25 min</span>
                </div>
                <div class="h-px bg-zinc-700 my-6"></div>
                <div class="flex justify-between text-emerald-400">
                    <span>Total paid</span>
                    <span id="success-total" class="font-bold">$0</span>
                </div>
            </div>
            
            <button onclick="hideSuccessModal(); resetAfterOrder()" 
                    class="w-full py-6 bg-white text-zinc-900 font-semibold rounded-3xl">
                TRACK MY ORDER
            </button>
            
            <button onclick="hideSuccessModal()" 
                    class="text-zinc-400 text-sm mt-8">Back to browsing</button>
        </div>
    </div>
    
    <!-- TOAST -->
    <div id="toast" class="hidden fixed bottom-6 right-6 bg-zinc-800 border border-orange-400 text-white px-6 py-4 rounded-3xl flex items-center gap-x-3 shadow-2xl">
        <span id="toast-text" class="font-medium"></span>
    </div>
    
    <!-- PROFILE MODAL -->
    <div id="profile-modal" onclick="if(event.target === this) hideProfileModal()" 
         class="hidden fixed inset-0 bg-black/70 z-[999] flex items-end md:items-center justify-center">
        <div onclick="event.stopImmediatePropagation()" 
             class="bg-zinc-900 w-full md:w-96 md:rounded-3xl md:max-h-[90vh] overflow-hidden rounded-t-3xl">
            
            <div class="p-6">
                <div class="flex justify-end">
                    <button onclick="hideProfileModal()" class="text-3xl leading-none text-zinc-400">×</button>
                </div>
                
                <div class="flex flex-col items-center">
                    <div class="w-24 h-24 bg-gradient-to-br from-orange-400 to-amber-500 rounded-3xl flex items-center justify-center text-6xl mb-4 shadow-inner">
                        👨🏻‍🍳
                    </div>
                    <div id="profile-name" class="font-semibold text-2xl">Alex Rivera</div>
                    <div class="text-emerald-400 text-sm">Premium member</div>
                </div>
            </div>
            
            <div class="px-6">
                <div class="grid grid-cols-3 gap-4 text-center py-6 border-y border-zinc-700">
                    <div>
                        <div class="text-3xl font-semibold">12</div>
                        <div class="text-xs text-zinc-400">Orders</div>
                    </div>
                    <div>
                        <div class="text-3xl font-semibold">4.9</div>
                        <div class="text-xs text-zinc-400">Rating</div>
                    </div>
                    <div>
                        <div class="text-3xl font-semibold">8</div>
                        <div class="text-xs text-zinc-400">Favorites</div>
                    </div>
                </div>
            </div>
            
            <div class="p-6 space-y-4">
                <div class="flex items-center justify-between py-3">
                    <div class="flex items-center gap-x-4">
                        <i class="fa-solid fa-heart w-5 text-red-400"></i>
                        <span class="font-medium">Favorites</span>
                    </div>
                    <i class="fa-solid fa-chevron-right text-zinc-400"></i>
                </div>
                <div class="flex items-center justify-between py-3">
                    <div class="flex items-center gap-x-4">
                        <i class="fa-solid fa-bell w-5"></i>
                        <span class="font-medium">Notifications</span>
                    </div>
                    <i class="fa-solid fa-chevron-right text-zinc-400"></i>
                </div>
                <div class="flex items-center justify-between py-3">
                    <div class="flex items-center gap-x-4">
                        <i class="fa-solid fa-wallet w-5"></i>
                        <span class="font-medium">Payment methods</span>
                    </div>
                    <i class="fa-solid fa-chevron-right text-zinc-400"></i>
                </div>
            </div>
            
            <div onclick="logout()" 
                 class="mx-6 mb-8 border border-red-400/30 hover:bg-red-400/10 transition-colors text-red-400 text-center py-6 rounded-3xl font-medium cursor-pointer">
                Sign out
            </div>
        </div>
    </div>
    
    <!-- MOBILE MENU OVERLAY -->
    <div onclick="this.classList.add('hidden')" id="mobile-menu-overlay"
         class="hidden lg:hidden fixed inset-0 bg-black/60 z-[999]">
        <div onclick="event.stopImmediatePropagation()" 
             class="bg-zinc-900 w-72 h-full">
            <!-- content populated by JS if needed -->
        </div>
    </div>

    <script>
        // Tailwind script run
        function initializeTailwind() {
            // Already included via CDN
        }
        
        // Sample menu data
        let menuItems = [
            {
                id: 1,
                name: "Classic Cheeseburger",
                price: 12.99,
                category: "burgers",
                img: "https://picsum.photos/id/201/600/400",
                desc: "Juicy beef patty, melted cheddar, fresh lettuce, tomato and our secret sauce on a toasted brioche bun.",
                rating: 4.9,
                calories: 680
            },
            {
                id: 2,
                name: "Margherita Pizza",
                price: 14.99,
                category: "pizza",
                img: "https://picsum.photos/id/292/600/400",
                desc: "San marzano tomatoes, fresh mozzarella, basil and extra virgin olive oil on a thin crispy crust.",
                rating: 4.8,
                calories: 920
            },
            {
                id: 3,
                name: "California Roll Sushi",
                price: 11.49,
                category: "asian",
                img: "https://picsum.photos/id/312/600/400",
                desc: "Crab, avocado and cucumber wrapped in sushi rice and nori seaweed.",
                rating: 4.7,
                calories: 310
            },
            {
                id: 4,
                name: "Falafel Bowl",
                price: 13.99,
                category: "healthy",
                img: "https://picsum.photos/id/431/600/400",
                desc: "Crispy falafel, quinoa, cherry tomatoes, cucumber, hummus and tahini dressing.",
                rating: 4.6,
                calories: 540
            },
            {
                id: 5,
                name: "Chocolate Lava Cake",
                price: 8.99,
                category: "dessert",
                img: "https://picsum.photos/id/488/600/400",
                desc: "Warm chocolate cake with a molten chocolate center. Served with vanilla ice cream.",
                rating: 5.0,
                calories: 720
            },
            {
                id: 6,
                name: "Spicy Chicken Tacos",
                price: 10.49,
                category: "mexican",
                img: "https://picsum.photos/id/63/600/400",
                desc: "Three corn tortillas filled with grilled chicken, pico de gallo and chipotle crema.",
                rating: 4.5,
                calories: 490
            },
            {
                id: 7,
                name: "Truffle Fries",
                price: 7.99,
                category: "sides",
                img: "https://picsum.photos/id/669/600/400",
                desc: "Crispy fries tossed in truffle oil, parmesan and fresh herbs.",
                rating: 4.8,
                calories: 410
            },
            {
                id: 8,
                name: "Mango Smoothie",
                price: 6.99,
                category: "drinks",
                img: "https://picsum.photos/id/870/600/400",
                desc: "Fresh mango, banana, almond milk and a touch of honey.",
                rating: 4.9,
                calories: 240
            }
        ]
        
        let cart = []
        let currentUser = null
        let currentFilter = 'all'
        let currentModalItem = null
        let favorites = [1, 3, 5]
        
        // Initialize Tailwind and render everything
        function init() {
            // Tailwind already ready
            renderHomeCategories()
            renderPopularItems()
            renderFullMenu()
            renderCategoryPills()
            renderSidebarCategories()
            
            // Demo login after 800ms
            setTimeout(() => {
                if (!currentUser) {
                    currentUser = {
                        name: "Alex Rivera",
                        email: "demo@feastly.com",
                        avatar: "👨🏻‍🍳"
                    }
                    updateUserUI()
                }
            }, 1200)
            
            // Keyboard shortcut for search
            document.addEventListener('keydown', function(e) {
                if (e.metaKey && e.key === "k") {
                    e.preventDefault()
                    const search = document.getElementById('search-input')
                    search.focus()
                }
            })
            
            // Show home by default
            showView('home')
        }
        
        function renderHomeCategories() {
            const categories = [
                { name: "Burgers", icon: "🍔", color: "bg-orange-400" },
                { name: "Pizza", icon: "🍕", color: "bg-red-400" },
                { name: "Asian", icon: "🍣", color: "bg-sky-400" },
                { name: "Healthy", icon: "🥗", color: "bg-emerald-400" },
                { name: "Dessert", icon: "🍰", color: "bg-pink-400" },
                { name: "Drinks", icon: "🥤", color: "bg-violet-400" }
            ]
            
            let html = ''
            categories.forEach(cat => {
                html += `
                    <div onclick="quickCategoryFilter('${cat.name}')" 
                         class="cursor-pointer ${cat.color} text-white h-28 rounded-3xl flex flex-col items-center justify-center gap-y-1 hover:scale-105 transition-transform">
                        <span class="text-4xl">${cat.icon}</span>
                        <span class="font-medium text-sm tracking-wider">${cat.name}</span>
                    </div>
                `
            })
            document.getElementById('home-categories').innerHTML = html
        }
        
        function renderPopularItems() {
            const container = document.getElementById('popular-grid')
            let html = ''
            
            // First 4 items
            const popular = menuItems.slice(0, 4)
            
            popular.forEach(item => {
                const isFav = favorites.includes(item.id)
                html += createMenuCard(item, isFav)
            })
            
            container.innerHTML = html
        }
        
        function createMenuCard(item, isFavorite = false) {
            return `
                <div onclick="showItemDetail(${item.id})" 
                     class="food-item bg-zinc-900 border border-zinc-800 rounded-3xl overflow-hidden cursor-pointer card-hover">
                    <div class="relative">
                        <img src="${item.img}" class="w-full h-44 object-cover">
                        ${isFavorite ? `
                        <div class="absolute top-4 right-4 bg-white text-red-500 text-xs w-6 h-6 flex items-center justify-center rounded-2xl shadow">
                            ❤️
                        </div>` : ''}
                    </div>
                    <div class="p-4">
                        <div class="flex justify-between items-baseline">
                            <div class="font-semibold text-base">${item.name}</div>
                            <div class="text-orange-400 font-bold">$${item.price}</div>
                        </div>
                        <div class="flex items-center justify-between text-xs mt-4">
                            <div class="flex items-center">
                                <span class="text-yellow-400">★</span>
                                <span class="ml-1">${item.rating}</span>
                            </div>
                            <div onclick="event.stopImmediatePropagation(); toggleFavorite(${item.id});" 
                                 class="text-zinc-400 hover:text-red-400 transition-colors">
                                <i class="fa-solid fa-heart ${isFavorite ? 'text-red-400' : ''}"></i>
                            </div>
                        </div>
                    </div>
                </div>
            `
        }
        
        function renderFullMenu(filteredItems = null) {
            const container = document.getElementById('full-menu-grid')
            let items = filteredItems || menuItems
            
            let html = ''
            items.forEach(item => {
                const isFav = favorites.includes(item.id)
                html += createMenuCard(item, isFav)
            })
            container.innerHTML = html
        }
        
        function renderCategoryPills() {
            const categories = ['All', 'Burgers', 'Pizza', 'Asian', 'Healthy', 'Dessert', 'Sides']
            let html = ''
            
            categories.forEach((cat, index) => {
                const active = (cat === 'All' && currentFilter === 'all') ? 'active' : ''
                html += `
                    <div onclick="setCategoryFilter('${cat}')" 
                         class="category-pill cursor-pointer whitespace-nowrap px-7 py-3 text-sm font-medium border border-zinc-700 rounded-3xl ${active}">
                        ${cat}
                    </div>
                `
            })
            
            document.getElementById('menu-category-pills').innerHTML = html
        }
        
        function setCategoryFilter(cat) {
            currentFilter = cat.toLowerCase()
            
            // refresh pills
            renderCategoryPills()
            
            let filtered = menuItems
            if (currentFilter !== 'all') {
                filtered = menuItems.filter(item => 
                    item.category.toLowerCase() === currentFilter
                )
            }
            
            renderFullMenu(filtered)
        }
        
        function renderSidebarCategories() {
            const cats = ['Burgers', 'Pizza', 'Sushi', 'Salads', 'Tacos']
            let html = ''
            cats.forEach(cat => {
                html += `
                    <div onclick="quickCategoryFilter('${cat}');" 
                         class="px-5 py-3 hover:bg-zinc-800 rounded-3xl cursor-pointer flex items-center gap-x-3 text-zinc-300">
                        <span>${cat}</span>
                    </div>
                `
            })
            document.getElementById('sidebar-categories').innerHTML = html
        }
        
        function updateCartUI() {
            // count
            let count = cart.length
            document.getElementById('cart-count-top').textContent = count
            
            // render items
            const container = document.getElementById('cart-items')
            container.innerHTML = ''
            
            if (cart.length === 0) {
                container.innerHTML = `
                    <div class="flex flex-col items-center justify-center h-full py-20 text-center text-zinc-400">
                        <div class="text-7xl mb-6 opacity-30">🛍️</div>
                        <div class="font-medium">Your cart is empty</div>
                        <div class="text-xs mt-3">When you add products to your cart,<br>they will appear here</div>
                    </div>
                `
                document.getElementById('cart-subtotal').textContent = '$0.00'
                document.getElementById('cart-total').textContent = '$0.00'
                document.getElementById('cart-total-small').textContent = '$0'
                return
            }
            
            let subtotal = 0
            
            cart.forEach((cartItem, index) => {
                const item = menuItems.find(m => m.id === cartItem.id)
                if (!item) return
                
                subtotal += item.price * cartItem.quantity
                
                const itemHTML = `
                    <div class="flex gap-4">
                        <div class="w-16 h-16 bg-zinc-700 rounded-2xl overflow-hidden">
                            <img src="${item.img}" class="w-full h-full object-cover">
                        </div>
                        <div class="flex-1">
                            <div class="flex justify-between">
                                <div class="font-medium leading-tight">${item.name}</div>
                                <div onclick="removeFromCart(${index}); event.stopImmediatePropagation()" 
                                     class="text-red-400 cursor-pointer text-xs">×</div>
                            </div>
                            <div class="text-xs text-zinc-400">$${item.price.toFixed(2)}</div>
                            
                            <div class="flex justify-between items-center mt-6">
                                <div class="flex border border-zinc-600 rounded-3xl items-center">
                                    <button onclick="changeCartQty(${index}, -1); event.stopImmediatePropagation()" 
                                            class="w-7 h-7 flex items-center justify-center text-lg leading-none">-</button>
                                    <div class="w-8 text-center font-medium">${cartItem.quantity}</div>
                                    <button onclick="changeCartQty(${index}, 1); event.stopImmediatePropagation()" 
                                            class="w-7 h-7 flex items-center justify-center text-lg leading-none">+</button>
                                </div>
                                <div class="font-semibold">$${(item.price * cartItem.quantity).toFixed(2)}</div>
                            </div>
                        </div>
                    </div>
                `
                container.innerHTML += itemHTML
            })
            
            const delivery = 3.99
            const service = 1.49
            const total = subtotal + delivery + service
            
            document.getElementById('cart-subtotal').textContent = '$' + subtotal.toFixed(2)
            document.getElementById('cart-total').textContent = '$' + total.toFixed(2)
            document.getElementById('cart-total-small').textContent = '$' + total.toFixed(2)
        }
        
        function addToCart(id) {
            const existing = cart.find(cartItem => cartItem.id === id)
            
            if (existing) {
                existing.quantity++
            } else {
                cart.push({
                    id: id,
                    quantity: 1
                })
            }
            
            updateCartUI()
            showToast(`Added to cart!`)
        }
        
        function removeFromCart(index) {
            cart.splice(index, 1)
            updateCartUI()
        }
        
        function changeCartQty(index, delta) {
            cart[index].quantity += delta
            if (cart[index].quantity < 1) cart[index].quantity = 1
            updateCartUI()
        }
        
        function toggleCart() {
            const panel = document.getElementById('cart-panel')
            if (panel.classList.contains('translate-x-full')) {
                panel.classList.remove('translate-x-full')
            } else {
                panel.classList.add('translate-x-full')
            }
        }
        
        function showItemDetail(id) {
            currentModalItem = menuItems.find(item => item.id === id)
            if (!currentModalItem) return
            
            const modal = document.getElementById('item-modal')
            
            document.getElementById('modal-image').style.backgroundImage = `url('${currentModalItem.img}')`
            document.getElementById('modal-name').textContent = currentModalItem.name
            document.getElementById('modal-category').textContent = currentModalItem.category.toUpperCase()
            document.getElementById('modal-price').textContent = '$' + currentModalItem.price
            document.getElementById('modal-desc').textContent = currentModalItem.desc
            document.getElementById('modal-rating').textContent = currentModalItem.rating
            document.getElementById('modal-calories').textContent = currentModalItem.calories + ' cal'
            document.getElementById('modal-price-bottom').textContent = currentModalItem.price.toFixed(2)
            
            modal.classList.remove('hidden')
            modal.classList.add('flex')
        }
        
        function closeItemModal() {
            const modal = document.getElementById('item-modal')
            modal.classList.add('hidden')
            modal.classList.remove('flex')
        }
        
        function addCurrentToCart() {
            if (currentModalItem) {
                addToCart(currentModalItem.id)
                closeItemModal()
            }
        }
        
        function showToast(message) {
            const toast = document.getElementById('toast')
            document.getElementById('toast-text').innerHTML = message
            toast.classList.remove('hidden')
            toast.style.transform = 'translateY(0)'
            
            setTimeout(() => {
                toast.style.transform = 'translateY(60px)'
                setTimeout(() => {
                    toast.classList.add('hidden')
                }, 400)
            }, 2700)
        }
        
        function performLogin() {
            const email = document.getElementById('login-email').value
            // fake login
            currentUser = {
                name: "Alex Rivera",
                email: email || "demo@feastly.com",
                avatar: "👨🏻‍🍳"
            }
            closeLoginModal()
            updateUserUI()
            showToast("Welcome back, Alex!")
        }
        
        function fakeGoogleLogin() {
            currentUser = {
                name: "Alex Rivera",
                email: "alex.r@google.com",
                avatar: "👨🏻‍🍳"
            }
            closeLoginModal()
            updateUserUI()
        }
        
        function fakeRegister() {
            closeLoginModal()
            showToast("Account created! Welcome 🎉")
            currentUser = {
                name: "New User",
                email: "hello@feastly.com",
                avatar: "🧑‍🍳"
            }
            updateUserUI()
        }
        
        function closeLoginModal() {
            document.getElementById('login-modal').classList.add('hidden')
        }
        
        function showLogin() {
            document.getElementById('login-modal').classList.remove('hidden')
        }
        
        function updateUserUI() {
            if (!currentUser) return
            // sidebar user
            const usernameEl = document.getElementById('sidebar-username')
            if (usernameEl) usernameEl.textContent = currentUser.name
        }
        
        function logout() {
            currentUser = null
            hideProfileModal()
            showToast("Signed out")
            // reset to guest
            setTimeout(() => {
                document.getElementById('sidebar-username').textContent = "Guest"
            }, 600)
        }
        
        function showProfileModal() {
            const modal = document.getElementById('profile-modal')
            if (currentUser) {
                document.getElementById('profile-name').textContent = currentUser.name
            }
            modal.classList.remove('hidden')
        }
        
        function hideProfileModal() {
            document.getElementById('profile-modal').classList.add('hidden')
        }
        
        function checkout() {
            if (cart.length === 0) return
            toggleCart() // close cart
            
            const totalEl = document.getElementById('cart-total')
            const total = totalEl.textContent
            
            document.getElementById('success-total').textContent = total
            document.getElementById('success-modal').classList.remove('hidden')
            document.getElementById('success-modal').classList.add('flex')
        }
        
        function hideSuccessModal() {
            const modal = document.getElementById('success-modal')
            modal.classList.add('hidden')
            modal.classList.remove('flex')
        }
        
        function resetAfterOrder() {
            // clear the cart
            cart = []
            updateCartUI()
            showToast("Thank you for ordering with Feastly!")
        }
        
        function showView(view) {
            // hide all views
            document.getElementById('view-home').classList.add('hidden')
            document.getElementById('view-menu').classList.add('hidden')
            document.getElementById('view-orders').classList.add('hidden')
            document.getElementById('view-favorites').classList.add('hidden')
            
            // show selected
            if (view === 'home') {
                document.getElementById('view-home').classList.remove('hidden')
            } else if (view === 'menu') {
                document.getElementById('view-menu').classList.remove('hidden')
                // make sure menu is rendered
                renderFullMenu()
            } else if (view === 'orders') {
                document.getElementById('view-orders').classList.remove('hidden')
            } else if (view === 'favorites') {
                renderFavorites()
                document.getElementById('view-favorites').classList.remove('hidden')
            }
        }
        
        function navigateTo(view) {
            // highlight active nav if needed
            showView(view)
            
            // close cart if open
            const panel = document.getElementById('cart-panel')
            if (!panel.classList.contains('translate-x-full')) {
                panel.classList.add('translate-x-full')
            }
        }
        
        function renderFavorites() {
            const container = document.getElementById('favorites-grid')
            const favItems = menuItems.filter(item => favorites.includes(item.id))
            
            let html = ''
            favItems.forEach(item => {
                html += createMenuCard(item, true)
            })
            
            if (favItems.length === 0) {
                html = `<div class="col-span-full py-12 text-center text-zinc-400">No favorites yet</div>`
            }
            
            container.innerHTML = html
        }
        
        function toggleFavorite(id) {
            if (favorites.includes(id)) {
                favorites = favorites.filter(favId => favId !== id)
            } else {
                favorites.push(id)
            }
            
            // refresh current views
            if (!document.getElementById('view-home').classList.contains('hidden')) {
                renderPopularItems()
            }
            if (!document.getElementById('view-menu').classList.contains('hidden')) {
                renderFullMenu()
            }
            if (!document.getElementById('view-favorites').classList.contains('hidden')) {
                renderFavorites()
            }
            
            event.stopImmediatePropagation()
        }
        
        function quickCategoryFilter(name) {
            navigateTo('menu')
            // map some names
            let mapped = name.toLowerCase()
            if (mapped === 'asian') mapped = 'asian'
            if (mapped === 'dessert') mapped = 'dessert'
            if (mapped === 'healthy') mapped = 'healthy'
            
            currentFilter = mapped
            renderCategoryPills()
            
            let filtered = menuItems
            if (mapped !== 'all') {
                filtered = menuItems.filter(i => i.category === mapped)
            }
            renderFullMenu(filtered)
        }
        
        function performSearch() {
            const term = document.getElementById('search-input').value.toLowerCase().trim()
            if (!term) {
                renderFullMenu()
                return
            }
            
            navigateTo('menu')
            
            const filtered = menuItems.filter(item => 
                item.name.toLowerCase().includes(term) ||
                item.desc.toLowerCase().includes(term)
            )
            
            renderFullMenu(filtered)
        }
        
        function filterMenu() {
            // simple demo: just re-render
            const filtered = [...menuItems]
            // could sort but skipping for demo
            renderFullMenu(filtered)
        }
        
        function toggleMobileMenu() {
            const overlay = document.getElementById('mobile-menu-overlay')
            overlay.classList.toggle('hidden')
        }
        
        function showRandomItem() {
            const randomIndex = Math.floor(Math.random() * menuItems.length)
            showItemDetail(menuItems[randomIndex].id)
        }
        
        // Close modals when pressing escape
        document.addEventListener('keydown', function(e) {
            if (e.key === "Escape") {
                const itemModal = document.getElementById('item-modal')
                const loginModal = document.getElementById('login-modal')
                const successModal = document.getElementById('success-modal')
                const profileModal = document.getElementById('profile-modal')
                
                if (!itemModal.classList.contains('hidden')) closeItemModal()
                else if (!loginModal.classList.contains('hidden')) closeLoginModal()
                else if (!successModal.classList.contains('hidden')) hideSuccessModal()
                else if (!profileModal.classList.contains('hidden')) hideProfileModal()
                else {
                    const cartPanel = document.getElementById('cart-panel')
                    if (!cartPanel.classList.contains('translate-x-full')) {
                        toggleCart()
                    }
                }
            }
        })
        
        // Click anywhere outside cart to close on mobile
        document.addEventListener('click', function(e) {
            const cartPanel = document.getElementById('cart-panel')
            if (window.innerWidth < 768 && 
                !cartPanel.contains(e.target) && 
                e.target.id !== 'cart-count-top') {
                // only close if open
            }
        })
        
        // Boot app
        window.onload = function() {
            init()
        }
    </script>
</body>
</html>
