<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>QuickBite — Food Delivery App</title>
  <style>
    :root{
      --bg:#f6f8fc;
      --card:#ffffff;
      --text:#0f172a;
      --muted:#64748b;
      --line:#e2e8f0;
      --primary:#ff6b35;
      --primary-2:#ff9f43;
      --accent:#7c3aed;
      --success:#16a34a;
      --danger:#ef4444;
      --shadow:0 20px 50px rgba(15,23,42,.10);
      --shadow-sm:0 10px 30px rgba(15,23,42,.08);
      --radius:24px;
    }
    *{box-sizing:border-box}
    html{scroll-behavior:smooth}
    body{
      margin:0;
      font-family:Inter,ui-sans-serif,system-ui,-apple-system,Segoe UI,Roboto,Helvetica,Arial,sans-serif;
      color:var(--text);
      background:
        radial-gradient(circle at top left, rgba(255,107,53,.12), transparent 32%),
        radial-gradient(circle at top right, rgba(124,58,237,.10), transparent 28%),
        linear-gradient(180deg, #fbfcff, #f6f8fc 50%, #eef3ff 100%);
      overflow-x:hidden;
    }
    body.lock{overflow:hidden}
    a{text-decoration:none;color:inherit}
    button,input,select,textarea{font:inherit}
    .container{width:min(1140px,calc(100% - 32px));margin:0 auto}
    .bg-blob{
      position:fixed;inset:auto auto 10% -120px;width:280px;height:280px;border-radius:50%;
      background:radial-gradient(circle, rgba(255,159,67,.18), transparent 65%);
      filter:blur(10px);pointer-events:none;z-index:0
    }
    .bg-blob.b2{inset:20% -120px auto auto;background:radial-gradient(circle, rgba(124,58,237,.16), transparent 65%)}
    .site-header{position:sticky;top:14px;z-index:20;padding:14px 0}
    .header-inner{
      display:flex;align-items:center;justify-content:space-between;gap:18px;
      background:rgba(255,255,255,.75);backdrop-filter:blur(16px);
      border:1px solid rgba(255,255,255,.8);box-shadow:var(--shadow-sm);
      padding:14px 18px;border-radius:22px
    }
    .brand{display:flex;align-items:center;gap:12px;font-weight:800;font-size:1.1rem}
    .brand-badge{
      width:42px;height:42px;border-radius:14px;display:grid;place-items:center;color:#fff;
      background:linear-gradient(135deg,var(--primary),var(--primary-2));box-shadow:0 12px 25px rgba(255,107,53,.35)
    }
    .nav{display:flex;gap:22px;color:var(--muted);font-weight:600}
    .nav a:hover{color:var(--text)}
    .header-actions{display:flex;align-items:center;gap:10px;flex-wrap:wrap;justify-content:flex-end}
    .btn,.btn-outline,.icon-btn,.chip,.tab-btn{
      border:none;cursor:pointer;transition:.2s ease;outline:none
    }
    .btn{
      background:linear-gradient(135deg,var(--primary),var(--primary-2));color:#fff;
      padding:12px 18px;border-radius:16px;font-weight:700;box-shadow:0 14px 28px rgba(255,107,53,.28)
    }
    .btn:hover{transform:translateY(-1px);filter:saturate(1.05)}
    .btn-outline{
      background:#fff;border:1px solid var(--line);color:var(--text);
      padding:11px 16px;border-radius:16px;font-weight:700
    }
    .btn-outline:hover,.icon-btn:hover,.chip:hover{background:#f8fafc}
    .icon-btn{
      display:inline-flex;align-items:center;gap:8px;background:#fff;border:1px solid var(--line);
      padding:11px 14px;border-radius:16px;font-weight:700;color:var(--text)
    }
    .cart-badge{
      min-width:22px;height:22px;border-radius:999px;display:grid;place-items:center;
      background:var(--text);color:#fff;font-size:.75rem;padding:0 6px
    }
    .user-box{display:flex;align-items:center;gap:8px}
    .user-pill,.mini-btn{
      background:#fff;border:1px solid var(--line);border-radius:999px;padding:10px 14px;font-weight:700;cursor:pointer
    }
    .mini-btn{padding:10px 12px;color:var(--danger)}
    .hero{
      position:relative;z-index:1;
      display:grid;grid-template-columns:1.05fr .95fr;gap:24px;align-items:center;
      padding:26px 0 8px
    }
    .hero-panel,.hero-phone{
      background:linear-gradient(180deg,rgba(255,255,255,.9),rgba(255,255,255,.74));
      border:1px solid rgba(255,255,255,.9);
      border-radius:32px;box-shadow:var(--shadow);padding:30px
    }
    .eyebrow{
      display:inline-flex;align-items:center;gap:8px;
      background:rgba(255,107,53,.10);color:#c2410c;
      padding:8px 12px;border-radius:999px;font-weight:800;font-size:.9rem
    }
    .hero h1{
      margin:16px 0 12px;font-size:clamp(2.2rem,5vw,4.3rem);line-height:.96;letter-spacing:-.04em
    }
    .hero p{margin:0 0 24px;color:var(--muted);font-size:1.05rem;max-width:54ch}
    .hero-actions{display:flex;gap:12px;flex-wrap:wrap}
    .hero-stats{
      display:grid;grid-template-columns:repeat(3,1fr);gap:14px;margin-top:28px
    }
    .stat{
      background:#fff;border:1px solid var(--line);border-radius:22px;padding:16px 14px;box-shadow:var(--shadow-sm)
    }
    .stat strong{display:block;font-size:1.25rem}
    .stat span{color:var(--muted);font-size:.92rem}
    .hero-phone{padding:18px;position:relative;overflow:hidden}
    .phone-shell{
      max-width:360px;margin-inline:auto;background:#111827;color:#fff;border-radius:34px;padding:14px;
      box-shadow:0 30px 60px rgba(15,23,42,.28)
    }
    .phone-screen{
      background:linear-gradient(180deg,#fff6f1,#ffffff 40%,#f7f8ff 100%);
      color:var(--text);border-radius:24px;padding:16px;min-height:520px;position:relative;overflow:hidden
    }
    .phone-top{display:flex;justify-content:space-between;align-items:center;font-weight:800}
    .search-mini{
      margin:14px 0 16px;background:#fff;border:1px solid #f1f5f9;border-radius:16px;padding:12px 14px;color:var(--muted)
    }
    .map-card{
      background:linear-gradient(135deg,#fde68a,#fb923c);color:#7c2d12;border-radius:22px;padding:18px;margin-bottom:14px;font-weight:800
    }
    .mini-order,.mini-track{
      background:#fff;border:1px solid #eef2f7;border-radius:22px;padding:14px;box-shadow:var(--shadow-sm)
    }
    .mini-order{margin-bottom:12px}
    .mini-row{display:flex;align-items:center;justify-content:space-between;gap:10px}
    .food-tag{
      width:42px;height:42px;border-radius:14px;display:grid;place-items:center;font-size:1.25rem;
      background:linear-gradient(135deg,#fff1eb,#ffe4d6)
    }
    .line{height:8px;background:#eef2ff;border-radius:999px;overflow:hidden;margin-top:12px}
    .line span{display:block;height:100%;width:76%;background:linear-gradient(90deg,var(--accent),#a78bfa)}
    .section{position:relative;z-index:1;padding:70px 0 10px}
    .section-head{
      display:flex;align-items:end;justify-content:space-between;gap:18px;flex-wrap:wrap;margin-bottom:20px
    }
    .section-head h2{margin:0;font-size:clamp(1.7rem,3vw,2.5rem);letter-spacing:-.03em}
    .section-head p{margin:8px 0 0;color:var(--muted)}
    .search-box{
      min-width:min(100%,320px);display:flex;align-items:center;gap:10px;
      background:#fff;border:1px solid var(--line);border-radius:18px;padding:0 14px;box-shadow:var(--shadow-sm)
    }
    .search-box input{
      width:100%;border:none;background:transparent;padding:14px 0;outline:none;color:var(--text)
    }
    .chips{display:flex;gap:10px;flex-wrap:wrap;margin-bottom:20px}
    .chip{
      background:#fff;border:1px solid var(--line);border-radius:999px;padding:11px 15px;font-weight:700;color:#334155
    }
    .chip.active{
      background:linear-gradient(135deg,var(--primary),var(--primary-2));color:#fff;border-color:transparent;
      box-shadow:0 12px 24px rgba(255,107,53,.25)
    }
    .menu-grid{
      display:grid;grid-template-columns:repeat(auto-fit,minmax(245px,1fr));gap:18px
    }
    .card{
      background:rgba(255,255,255,.88);border:1px solid rgba(255,255,255,.92);border-radius:26px;
      overflow:hidden;box-shadow:var(--shadow-sm);transition:.22s ease
    }
    .card:hover{transform:translateY(-4px);box-shadow:var(--shadow)}
    .card-visual{
      height:170px;padding:18px;display:flex;align-items:flex-start;justify-content:space-between;color:#fff
    }
    .visual-emoji{
      width:64px;height:64px;border-radius:20px;background:rgba(255,255,255,.22);backdrop-filter:blur(8px);
      display:grid;place-items:center;font-size:2rem
    }
    .pill{
      background:rgba(255,255,255,.24);backdrop-filter:blur(8px);padding:8px 10px;border-radius:999px;font-weight:800;font-size:.82rem
    }
    .card-body{padding:18px}
    .meta{display:flex;gap:8px;flex-wrap:wrap;margin:10px 0 14px}
    .meta span{
      background:#f8fafc;border:1px solid #edf2f7;color:#475569;padding:7px 10px;border-radius:999px;font-size:.84rem;font-weight:700
    }
    .card h3{margin:0;font-size:1.12rem}
    .card p{margin:8px 0 0;color:var(--muted);font-size:.94rem;min-height:42px}
    .card-foot{display:flex;align-items:center;justify-content:space-between;gap:12px;margin-top:16px}
    .price{font-size:1.18rem;font-weight:900}
    .add-btn{
      background:var(--text);color:#fff;border:none;border-radius:14px;padding:11px 13px;font-weight:800;cursor:pointer
    }
    .add-btn:hover{opacity:.92}
    .steps-grid,.orders-grid{
      display:grid;grid-template-columns:repeat(3,1fr);gap:18px
    }
    .step,.order-card,.empty{
      background:rgba(255,255,255,.85);border:1px solid rgba(255,255,255,.92);border-radius:24px;
      padding:22px;box-shadow:var(--shadow-sm)
    }
    .step-icon{
      width:54px;height:54px;border-radius:18px;display:grid;place-items:center;margin-bottom:16px;
      background:linear-gradient(135deg,var(--accent),#a78bfa);color:#fff;font-size:1.35rem
    }
    .step h3,.order-card h3{margin:0 0 8px}
    .step p,.order-card p{margin:0;color:var(--muted)}
    .order-top{display:flex;justify-content:space-between;gap:10px;align-items:flex-start;margin-bottom:12px}
    .status{
      padding:8px 11px;border-radius:999px;font-size:.82rem;font-weight:800;background:#ecfdf5;color:#15803d
    }
    .status.preparing{background:#fff7ed;color:#c2410c}
    .status.route{background:#eef2ff;color:#4338ca}
    .order-items{margin:12px 0;color:#475569;font-size:.95rem}
    .footer{
      position:relative;z-index:1;padding:50px 0 70px;color:var(--muted);text-align:center
    }
    .overlay{
      position:fixed;inset:0;background:rgba(15,23,42,.48);backdrop-filter:blur(3px);
      opacity:0;pointer-events:none;transition:.25s;z-index:50
    }
    .overlay.show{opacity:1;pointer-events:auto}
    .drawer{
      position:fixed;top:0;right:0;height:100vh;width:min(420px,100%);background:#fff;
      transform:translateX(100%);transition:.28s ease;z-index:70;display:flex;flex-direction:column;
      box-shadow:-20px 0 60px rgba(15,23,42,.18)
    }
    .drawer.open{transform:translateX(0)}
    .drawer-head,.drawer-foot{padding:20px;border-bottom:1px solid var(--line)}
    .drawer-foot{border-top:1px solid var(--line);border-bottom:none;margin-top:auto;background:#fff}
    .drawer-title{display:flex;align-items:center;justify-content:space-between;gap:12px}
    .close-btn{
      width:40px;height:40px;border-radius:14px;border:1px solid var(--line);background:#fff;cursor:pointer
    }
    .cart-items{padding:16px;display:flex;flex-direction:column;gap:12px;overflow:auto}
    .cart-item{
      display:grid;grid-template-columns:56px 1fr auto;gap:12px;align-items:center;
      background:#f8fafc;border:1px solid #edf2f7;border-radius:18px;padding:12px
    }
    .cart-thumb{
      width:56px;height:56px;border-radius:16px;display:grid;place-items:center;font-size:1.5rem;color:#fff
    }
    .cart-item h4{margin:0 0 4px;font-size:.98rem}
    .cart-item .small{color:var(--muted);font-size:.88rem}
    .qty{
      display:flex;align-items:center;gap:8px;margin-top:10px
    }
    .qty button{
      width:28px;height:28px;border-radius:10px;border:1px solid var(--line);background:#fff;cursor:pointer;font-weight:900
    }
    .totals{display:flex;flex-direction:column;gap:10px;margin-bottom:14px}
    .total-row{display:flex;justify-content:space-between;gap:12px;color:#475569}
    .total-row strong{color:var(--text)}
    .modal{
      position:fixed;inset:0;display:grid;place-items:center;opacity:0;pointer-events:none;transition:.25s;z-index:80;padding:18px
    }
    .modal.open{opacity:1;pointer-events:auto}
    .panel{
      width:min(560px,100%);background:#fff;border-radius:30px;box-shadow:var(--shadow);overflow:hidden;
      border:1px solid rgba(255,255,255,.92);transform:translateY(16px) scale(.98);transition:.25s
    }
    .modal.open .panel{transform:translateY(0) scale(1)}
    .panel-head{padding:22px 22px 14px;display:flex;align-items:flex-start;justify-content:space-between;gap:16px}
    .panel-head h3{margin:0;font-size:1.35rem}
    .panel-head p{margin:6px 0 0;color:var(--muted)}
    .panel-body{padding:0 22px 22px}
    .tabs{display:flex;background:#f8fafc;border:1px solid #edf2f7;border-radius:16px;padding:4px;margin-bottom:18px}
    .tab-btn{flex:1;background:transparent;border-radius:12px;padding:11px 12px;font-weight:800;color:#64748b}
    .tab-btn.active{background:#fff;color:var(--text);box-shadow:var(--shadow-sm)}
    .auth-panel{display:none}
    .auth-panel.active{display:block}
    .form-grid{display:grid;grid-template-columns:repeat(2,1fr);gap:14px}
    .field{display:flex;flex-direction:column;gap:8px;margin-bottom:14px}
    .field label{font-size:.92rem;font-weight:700}
    .field input,.field textarea,.field select{
      width:100%;border:1px solid var(--line);background:#fff;border-radius:16px;padding:13px 14px;outline:none
    }
    .field textarea{resize:vertical;min-height:90px}
    .full{grid-column:1 / -1}
    .radio-wrap{display:grid;grid-template-columns:repeat(3,1fr);gap:10px}
    .radio{
      border:1px solid var(--line);border-radius:16px;padding:12px;text-align:center;font-weight:700;cursor:pointer
    }
    .radio input{display:none}
    .radio.active{border-color:var(--text);background:#f8fafc}
    .summary-box{
      background:#f8fafc;border:1px solid #edf2f7;border-radius:18px;padding:14px;margin-bottom:16px
    }
    .summary-item,.summary-total{display:flex;justify-content:space-between;gap:10px;padding:7px 0;color:#475569}
    .summary-total{border-top:1px solid #e2e8f0;margin-top:8px;padding-top:12px;color:var(--text);font-weight:800}
    .toast-wrap{
      position:fixed;right:18px;bottom:18px;display:flex;flex-direction:column;gap:10px;z-index:100
    }
    .toast{
      background:#111827;color:#fff;padding:12px 14px;border-radius:16px;box-shadow:var(--shadow);animation:toastIn .25s ease
    }
    .empty{
      text-align:center;padding:28px
    }
    .muted{color:var(--muted)}
    @keyframes toastIn{
      from{opacity:0;transform:translateY(10px)}to{opacity:1;transform:translateY(0)}
    }
    @media (max-width: 980px){
      .hero{grid-template-columns:1fr}
      .steps-grid,.orders-grid{grid-template-columns:1fr}
      .nav{display:none}
    }
    @media (max-width: 640px){
      .header-inner{padding:12px 14px}
      .hero-panel,.hero-phone{padding:22px}
      .hero-stats{grid-template-columns:1fr}
      .form-grid,.radio-wrap{grid-template-columns:1fr}
      .section{padding-top:56px}
      .panel-head,.panel-body{padding-left:16px;padding-right:16px}
      .drawer-head,.drawer-foot{padding:16px}
      .cart-items{padding:12px}
    }
  </style>
</head>
<body>
  <div class="bg-blob"></div>
  <div class="bg-blob b2"></div>

  <header class="site-header">
    <div class="container header-inner">
      <a href="#home" class="brand">
        <span class="brand-badge">🍔</span>
        <span>QuickBite</span>
      </a>
      <nav class="nav">
        <a href="#menu">Menu</a>
        <a href="#how">How it works</a>
        <a href="#orders">Orders</a>
      </nav>
      <div class="header-actions">
        <div id="authArea"></div>
        <button id="cartButton" class="icon-btn">
          Cart <span id="cartCount" class="cart-badge">0</span>
        </button>
      </div>
    </div>
  </header>

  <main>
    <section class="container hero" id="home">
      <div class="hero-panel">
        <span class="eyebrow">⚡ Fast delivery in 30 minutes</span>
        <h1>Your favorite food, delivered fresh & fast.</h1>
        <p>Login, browse the full food menu, add items to your cart, and place your order in seconds. A modern food delivery experience built for mobile and desktop.</p>
        <div class="hero-actions">
          <a href="#menu" class="btn">Start Ordering</a>
          <button id="heroCartBtn" class="btn-outline">View Cart</button>
        </div>
        <div class="hero-stats">
          <div class="stat"><strong>4.9★</strong><span>Top rated meals</span></div>
          <div class="stat"><strong>25 min</strong><span>Average delivery</span></div>
          <div class="stat"><strong>500+</strong><span>Orders every day</span></div>
        </div>
      </div>

      <div class="hero-phone">
        <div class="phone-shell">
          <div class="phone-screen">
            <div class="phone-top">
              <span>QuickBite</span>
              <span>12:30</span>
            </div>
            <div class="search-mini">🔎 Search burgers, pizza, drinks...</div>
            <div class="map-card">Courier is 8 minutes away 🚴</div>
            <div class="mini-order">
              <div class="mini-row">
                <div style="display:flex;align-items:center;gap:10px">
                  <div class="food-tag">🍕</div>
                  <div>
                    <strong>Margherita Pizza</strong>
                    <div class="muted" style="font-size:.9rem">Extra cheese • Hot</div>
                  </div>
                </div>
                <strong>$14.99</strong>
              </div>
              <div class="line"><span></span></div>
            </div>
            <div class="mini-track">
              <div class="mini-row">
                <div>
                  <strong>Order summary</strong>
                  <div class="muted" style="font-size:.9rem">2 items • Free tracking</div>
                </div>
                <strong>$24.98</strong>
              </div>
              <div style="margin-top:14px;display:grid;gap:10px">
                <div class="mini-row">
                  <span class="muted">🍔 Smash Burger</span><strong>$12.99</strong>
                </div>
                <div class="mini-row">
                  <span class="muted">🥤 Mango Smoothie</span><strong>$5.99</strong>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </section>

    <section class="container section" id="menu">
      <div class="section-head">
        <div>
          <h2>Popular food menu</h2>
          <p>Choose from best-selling meals, healthy bowls, drinks, and desserts.</p>
        </div>
        <div class="search-box">
          <span>🔎</span>
          <input id="searchInput" type="text" placeholder="Search your favorite food..." />
        </div>
      </div>
      <div id="categoryFilters" class="chips"></div>
      <div id="menuGrid" class="menu-grid"></div>
    </section>

    <section class="container section" id="how">
      <div class="section-head">
        <div>
          <h2>How it works</h2>
          <p>Simple ordering flow designed like a real food delivery app.</p>
        </div>
      </div>
      <div class="steps-grid">
        <div class="step">
          <div class="step-icon">1</div>
          <h3>Login or create account</h3>
          <p>Save your delivery details and access your personal order list anytime.</p>
        </div>
        <div class="step">
          <div class="step-icon">2</div>
          <h3>Browse the menu</h3>
          <p>Use search and category filters to find burgers, pizza, bowls, drinks, and more.</p>
        </div>
        <div class="step">
          <div class="step-icon">3</div>
          <h3>Place your order</h3>
          <p>Add items to the cart, enter address, choose payment method, and confirm checkout.</p>
        </div>
      </div>
    </section>

    <section class="container section" id="orders">
      <div class="section-head">
        <div>
          <h2>Your recent orders</h2>
          <p>Login to see your order history and latest order status.</p>
        </div>
      </div>
      <div id="ordersList" class="orders-grid"></div>
    </section>
  </main>

  <footer class="footer">
    <div class="container">© 2026 QuickBite — Fresh meals, smooth ordering, fast delivery.</div>
  </footer>

  <div id="overlay" class="overlay"></div>

  <aside id="cartDrawer" class="drawer">
    <div class="drawer-head">
      <div class="drawer-title">
        <div>
          <h3 style="margin:0">Your Cart</h3>
          <p class="muted" style="margin:6px 0 0">Review your selected items</p>
        </div>
        <button class="close-btn" data-close="drawer">✕</button>
      </div>
    </div>
    <div id="cartItems" class="cart-items"></div>
    <div class="drawer-foot">
      <div class="totals">
        <div class="total-row"><span>Subtotal</span><strong id="subtotalValue">$0.00</strong></div>
        <div class="total-row"><span>Delivery fee</span><strong id="deliveryValue">$0.00</strong></div>
        <div class="total-row"><span>Total</span><strong id="totalValue">$0.00</strong></div>
      </div>
      <button id="checkoutButton" class="btn" style="width:100%">Proceed to Checkout</button>
    </div>
  </aside>

  <div id="authModal" class="modal">
    <div class="panel">
      <div class="panel-head">
        <div>
          <h3>Welcome to QuickBite</h3>
          <p>Login to order food or create a new account.</p>
        </div>
        <button class="close-btn" data-close="auth">✕</button>
      </div>
      <div class="panel-body">
        <div class="tabs">
          <button class="tab-btn active" data-tab="login">Login</button>
          <button class="tab-btn" data-tab="register">Register</button>
        </div>

        <div id="loginPanel" class="auth-panel active">
          <form id="loginForm">
            <div class="field">
              <label>Email</label>
              <input type="email" id="loginEmail" placeholder="you@example.com" required />
            </div>
            <div class="field">
              <label>Password</label>
              <input type="password" id="loginPassword" placeholder="Enter password" required />
            </div>
            <button class="btn" style="width:100%">Login</button>
          </form>
        </div>

        <div id="registerPanel" class="auth-panel">
          <form id="registerForm">
            <div class="field">
              <label>Full name</label>
              <input type="text" id="registerName" placeholder="Your name" required />
            </div>
            <div class="field">
              <label>Email</label>
              <input type="email" id="registerEmail" placeholder="you@example.com" required />
            </div>
            <div class="field">
              <label>Password</label>
              <input type="password" id="registerPassword" placeholder="Create password" required />
            </div>
            <button class="btn" style="width:100%">Create Account</button>
          </form>
        </div>
      </div>
    </div>
  </div>

  <div id="checkoutModal" class="modal">
    <div class="panel">
      <div class="panel-head">
        <div>
          <h3>Checkout</h3>
          <p>Confirm delivery details and place your order.</p>
        </div>
        <button class="close-btn" data-close="checkout">✕</button>
      </div>
      <div class="panel-body">
        <div id="checkoutSummary" class="summary-box"></div>
        <form id="checkoutForm">
          <div class="form-grid">
            <div class="field">
              <label>Full name</label>
              <input type="text" id="checkoutName" required />
            </div>
            <div class="field">
              <label>Email</label>
              <input type="email" id="checkoutEmail" required />
            </div>
            <div class="field">
              <label>Phone number</label>
              <input type="tel" id="checkoutPhone" placeholder="+1 555 123 4567" required />
            </div>
            <div class="field">
              <label>City</label>
              <input type="text" id="checkoutCity" placeholder="New York" required />
            </div>
            <div class="field full">
              <label>Delivery address</label>
              <textarea id="checkoutAddress" placeholder="Street, house, apartment..." required></textarea>
            </div>
            <div class="field full">
              <label>Payment method</label>
              <div class="radio-wrap" id="paymentOptions">
                <label class="radio active"><input type="radio" name="payment" value="Cash" checked />Cash</label>
                <label class="radio"><input type="radio" name="payment" value="Card" />Card</label>
                <label class="radio"><input type="radio" name="payment" value="Wallet" />Wallet</label>
              </div>
            </div>
          </div>
          <button class="btn" style="width:100%">Place Order</button>
        </form>
      </div>
    </div>
  </div>

  <div id="successModal" class="modal">
    <div class="panel" style="max-width:460px">
      <div class="panel-body" style="padding-top:26px;text-align:center">
        <div style="width:78px;height:78px;border-radius:24px;background:linear-gradient(135deg,#22c55e,#86efac);display:grid;place-items:center;color:#fff;font-size:2rem;margin:0 auto 18px">✓</div>
        <h3 style="margin:0 0 8px">Order placed successfully</h3>
        <p id="successText" class="muted" style="margin:0 0 18px">Your food is now being prepared.</p>
        <button id="viewOrdersBtn" class="btn" style="width:100%;margin-bottom:10px">View My Orders</button>
        <button class="btn-outline" data-close="success" style="width:100%">Continue Browsing</button>
      </div>
    </div>
  </div>

  <div id="toastWrap" class="toast-wrap"></div>

  <script>
    const menuData = [
      {id:1,name:"Smash Burger",category:"Burgers",price:12.99,rating:4.8,time:"20-25 min",emoji:"🍔",tag:"Popular",gradient:"linear-gradient(135deg,#ff9966,#ff5e62)",desc:"Double beef patty, cheddar, pickles, crispy onions, house sauce."},
      {id:2,name:"Margherita Pizza",category:"Pizza",price:14.99,rating:4.7,time:"25-30 min",emoji:"🍕",tag:"Best Seller",gradient:"linear-gradient(135deg,#f6d365,#fda085)",desc:"Stone-baked crust, tomato sauce, mozzarella, basil leaves."},
      {id:3,name:"Chicken Biryani",category:"Specials",price:13.49,rating:4.9,time:"25-35 min",emoji:"🍛",tag:"Chef Pick",gradient:"linear-gradient(135deg,#fbc2eb,#a18cd1)",desc:"Fragrant basmati rice, chicken, herbs, and aromatic spices."},
      {id:4,name:"Sushi Box",category:"Asian",price:16.99,rating:4.8,time:"20-30 min",emoji:"🍣",tag:"Fresh",gradient:"linear-gradient(135deg,#84fab0,#8fd3f4)",desc:"Salmon, avocado, cucumber rolls with soy and wasabi."},
      {id:5,name:"Caesar Salad",category:"Healthy",price:10.99,rating:4.6,time:"15-20 min",emoji:"🥗",tag:"Healthy",gradient:"linear-gradient(135deg,#d4fc79,#96e6a1)",desc:"Crisp romaine, grilled chicken, parmesan, croutons, dressing."},
      {id:6,name:"Ramen Bowl",category:"Asian",price:15.49,rating:4.7,time:"20-25 min",emoji:"🍜",tag:"Hot",gradient:"linear-gradient(135deg,#f093fb,#f5576c)",desc:"Rich broth, noodles, marinated egg, greens, and chicken."},
      {id:7,name:"Tacos Trio",category:"Specials",price:11.99,rating:4.6,time:"15-20 min",emoji:"🌮",tag:"Spicy",gradient:"linear-gradient(135deg,#f6d365,#fda085)",desc:"Three loaded tacos with salsa, slaw, and lime crema."},
      {id:8,name:"Pasta Alfredo",category:"Pasta",price:13.99,rating:4.7,time:"20-25 min",emoji:"🍝",tag:"Creamy",gradient:"linear-gradient(135deg,#fccb90,#d57eeb)",desc:"Creamy alfredo sauce, parmesan, herbs, and grilled chicken."},
      {id:9,name:"Mango Smoothie",category:"Drinks",price:5.99,rating:4.9,time:"10-15 min",emoji:"🥤",tag:"Cold",gradient:"linear-gradient(135deg,#ffe259,#ffa751)",desc:"Fresh mango, yogurt, honey, and crushed ice."},
      {id:10,name:"Chocolate Lava Cake",category:"Desserts",price:6.49,rating:4.9,time:"15-20 min",emoji:"🍫",tag:"Sweet",gradient:"linear-gradient(135deg,#8360c3,#2ebf91)",desc:"Warm chocolate cake with gooey center and vanilla cream."},
      {id:11,name:"Veggie Wrap",category:"Healthy",price:9.99,rating:4.5,time:"15-18 min",emoji:"🌯",tag:"Light",gradient:"linear-gradient(135deg,#c2ffd8,#465efb)",desc:"Grilled vegetables, hummus, greens, and soft tortilla wrap."},
      {id:12,name:"Pepperoni Pizza",category:"Pizza",price:15.99,rating:4.8,time:"25-30 min",emoji:"🍕",tag:"Hot",gradient:"linear-gradient(135deg,#ff758c,#ff7eb3)",desc:"Pepperoni, mozzarella, tomato sauce, and oregano on thin crust."}
    ];

    const state = {
      users: JSON.parse(localStorage.getItem("qb_users") || "[]"),
      currentUser: JSON.parse(localStorage.getItem("qb_currentUser") || "null"),
      cart: JSON.parse(localStorage.getItem("qb_cart") || "[]"),
      orders: JSON.parse(localStorage.getItem("qb_orders") || "[]"),
      category: "All",
      search: ""
    };

    let checkoutAfterAuth = false;

    const authArea = document.getElementById("authArea");
    const cartButton = document.getElementById("cartButton");
    const cartCount = document.getElementById("cartCount");
    const heroCartBtn = document.getElementById("heroCartBtn");
    const searchInput = document.getElementById("searchInput");
    const categoryFilters = document.getElementById("categoryFilters");
    const menuGrid = document.getElementById("menuGrid");
    const ordersList = document.getElementById("ordersList");
    const overlay = document.getElementById("overlay");
    const cartDrawer = document.getElementById("cartDrawer");
    const cartItems = document.getElementById("cartItems");
    const subtotalValue = document.getElementById("subtotalValue");
    const deliveryValue = document.getElementById("deliveryValue");
    const totalValue = document.getElementById("totalValue");
    const checkoutButton = document.getElementById("checkoutButton");

    const authModal = document.getElementById("authModal");
    const checkoutModal = document.getElementById("checkoutModal");
    const successModal = document.getElementById("successModal");
    const toastWrap = document.getElementById("toastWrap");

    const loginForm = document.getElementById("loginForm");
    const registerForm = document.getElementById("registerForm");
    const checkoutForm = document.getElementById("checkoutForm");
    const checkoutSummary = document.getElementById("checkoutSummary");
    const successText = document.getElementById("successText");
    const viewOrdersBtn = document.getElementById("viewOrdersBtn");

    const tabs = document.querySelectorAll(".tab-btn");
    const authPanels = {
      login: document.getElementById("loginPanel"),
      register: document.getElementById("registerPanel")
    };

    function money(n){ return `$${n.toFixed(2)}`; }
    function save(key, value){ localStorage.setItem(key, JSON.stringify(value)); }
    function persist(){
      save("qb_users", state.users);
      save("qb_cart", state.cart);
      save("qb_orders", state.orders);
      if(state.currentUser) save("qb_currentUser", state.currentUser);
      else localStorage.removeItem("qb_currentUser");
    }
    function toast(msg){
      const el = document.createElement("div");
      el.className = "toast";
      el.textContent = msg;
      toastWrap.appendChild(el);
      setTimeout(()=>{ el.style.opacity = "0"; el.style.transform = "translateY(10px)"; }, 2200);
      setTimeout(()=> el.remove(), 2600);
    }
    function updateOverlay(){
      const modalOpen = [...document.querySelectorAll(".modal")].some(m => m.classList.contains("open"));
      const open = cartDrawer.classList.contains("open") || modalOpen;
      overlay.classList.toggle("show", open);
      document.body.classList.toggle("lock", open);
    }
    function closeAll(){
      cartDrawer.classList.remove("open");
      authModal.classList.remove("open");
      checkoutModal.classList.remove("open");
      successModal.classList.remove("open");
      updateOverlay();
    }
    function openDrawer(){ cartDrawer.classList.add("open"); updateOverlay(); }
    function openAuth(tab="login"){
      switchTab(tab);
      authModal.classList.add("open");
      updateOverlay();
    }
    function openCheckout(){
      if(!state.cart.length) return toast("Your cart is empty.");
      if(!state.currentUser){
        checkoutAfterAuth = true;
        return openAuth("login");
      }
      cartDrawer.classList.remove("open");
      renderCheckoutSummary();
      document.getElementById("checkoutName").value = state.currentUser.name || "";
      document.getElementById("checkoutEmail").value = state.currentUser.email || "";
      checkoutModal.classList.add("open");
      updateOverlay();
    }
    function openSuccess(text){
      successText.textContent = text;
      successModal.classList.add("open");
      updateOverlay();
    }
    function switchTab(tab){
      tabs.forEach(btn => btn.classList.toggle("active", btn.dataset.tab === tab));
      Object.keys(authPanels).forEach(key => authPanels[key].classList.toggle("active", key === tab));
    }
    function getCategories(){
      return ["All", ...new Set(menuData.map(item => item.category))];
    }
    function getCartCount(){
      return state.cart.reduce((sum, item) => sum + item.qty, 0);
    }
    function getCartTotals(){
      const subtotal = state.cart.reduce((sum, entry) => {
        const item = menuData.find(m => m.id === entry.id);
        return sum + (item ? item.price * entry.qty : 0);
      }, 0);
      const delivery = subtotal > 0 ? 4.99 : 0;
      return { subtotal, delivery, total: subtotal + delivery };
    }
    function renderAuthArea(){
      if(state.currentUser){
        const firstName = state.currentUser.name.split(" ")[0];
        authArea.innerHTML = `
          <div class="user-box">
            <button class="user-pill" id="ordersShortcut">👋 ${firstName}</button>
            <button class="mini-btn" id="logoutBtn">Logout</button>
          </div>
        `;
      } else {
        authArea.innerHTML = `<button class="btn-outline" id="openAuthBtn">Login</button>`;
      }
    }
    function renderCategories(){
      categoryFilters.innerHTML = getCategories().map(cat => `
        <button class="chip ${state.category === cat ? "active" : ""}" data-category="${cat}">${cat}</button>
      `).join("");
    }
    function renderMenu(){
      const filtered = menuData.filter(item => {
        const matchCategory = state.category === "All" || item.category === state.category;
        const term = state.search.trim().toLowerCase();
        const matchSearch = !term || [item.name, item.category, item.desc].join(" ").toLowerCase().includes(term);
        return matchCategory && matchSearch;
      });

      if(!filtered.length){
        menuGrid.innerHTML = `<div class="empty" style="grid-column:1/-1"><h3 style="margin-top:0">No food found</h3><p class="muted">Try another category or search keyword.</p></div>`;
        return;
      }

      menuGrid.innerHTML = filtered.map(item => `
        <article class="card">
          <div class="card-visual" style="background:${item.gradient}">
            <span class="pill">${item.tag}</span>
            <div class="visual-emoji">${item.emoji}</div>
          </div>
          <div class="card-body">
            <h3>${item.name}</h3>
            <p>${item.desc}</p>
            <div class="meta">
              <span>★ ${item.rating}</span>
              <span>⏱ ${item.time}</span>
              <span>${item.category}</span>
            </div>
            <div class="card-foot">
              <div class="price">${money(item.price)}</div>
              <button class="add-btn" data-add="${item.id}">Add to Cart</button>
            </div>
          </div>
        </article>
      `).join("");
    }
    function renderCart(){
      cartCount.textContent = getCartCount();
      const { subtotal, delivery, total } = getCartTotals();
      subtotalValue.textContent = money(subtotal);
      deliveryValue.textContent = money(delivery);
      totalValue.textContent = money(total);

      if(!state.cart.length){
        cartItems.innerHTML = `
          <div class="empty">
            <h3 style="margin-top:0">Your cart is empty</h3>
            <p class="muted">Add something delicious from the menu.</p>
          </div>
        `;
        return;
      }

      cartItems.innerHTML = state.cart.map(entry => {
        const item = menuData.find(i => i.id === entry.id);
        if(!item) return "";
        return `
          <div class="cart-item">
            <div class="cart-thumb" style="background:${item.gradient}">${item.emoji}</div>
            <div>
              <h4>${item.name}</h4>
              <div class="small">${money(item.price)} each</div>
              <div class="qty">
                <button data-qty="-1" data-id="${item.id}">−</button>
                <strong>${entry.qty}</strong>
                <button data-qty="1" data-id="${item.id}">+</button>
              </div>
            </div>
            <strong>${money(item.price * entry.qty)}</strong>
          </div>
        `;
      }).join("");
    }
    function renderCheckoutSummary(){
      const { subtotal, delivery, total } = getCartTotals();
      checkoutSummary.innerHTML = `
        ${state.cart.map(entry => {
          const item = menuData.find(i => i.id === entry.id);
          if(!item) return "";
          return `<div class="summary-item"><span>${item.name} × ${entry.qty}</span><strong>${money(item.price * entry.qty)}</strong></div>`;
        }).join("")}
        <div class="summary-item"><span>Delivery fee</span><strong>${money(delivery)}</strong></div>
        <div class="summary-total"><span>Total</span><strong>${money(total)}</strong></div>
      `;
    }
    function renderOrders(){
      if(!state.currentUser){
        ordersList.innerHTML = `<div class="empty" style="grid-column:1/-1"><h3 style="margin-top:0">Login to view your orders</h3><p class="muted">Your placed orders will appear here after checkout.</p></div>`;
        return;
      }

      const myOrders = state.orders.filter(order => order.email === state.currentUser.email);
      if(!myOrders.length){
        ordersList.innerHTML = `<div class="empty" style="grid-column:1/-1"><h3 style="margin-top:0">No orders yet</h3><p class="muted">Start by adding food to your cart and placing your first order.</p></div>`;
        return;
      }

      ordersList.innerHTML = myOrders.slice(0, 6).map((order, index) => {
        const statusClass = index === 0 ? "preparing" : (index === 1 ? "route" : "");
        const statusText = index === 0 ? "Preparing" : (index === 1 ? "On the way" : "Delivered");
        return `
          <div class="order-card">
            <div class="order-top">
              <div>
                <h3>${order.orderNo}</h3>
                <p>${new Date(order.createdAt).toLocaleString()}</p>
              </div>
              <span class="status ${statusClass}">${statusText}</span>
            </div>
            <div class="order-items">${order.items.map(i => `${i.name} × ${i.qty}`).join(", ")}</div>
            <div class="total-row"><span>Payment</span><strong>${order.payment}</strong></div>
            <div class="total-row"><span>Total</span><strong>${money(order.total)}</strong></div>
          </div>
        `;
      }).join("");
    }
    function addToCart(id){
      const found = state.cart.find(item => item.id === id);
      if(found) found.qty += 1;
      else state.cart.push({ id, qty: 1 });
      persist();
      renderCart();
      toast("Added to cart");
    }
    function changeQty(id, delta){
      const item = state.cart.find(entry => entry.id === id);
      if(!item) return;
      item.qty += delta;
      if(item.qty <= 0) state.cart = state.cart.filter(entry => entry.id !== id);
      persist();
      renderCart();
    }

    renderAuthArea();
    renderCategories();
    renderMenu();
    renderCart();
    renderOrders();

    searchInput.addEventListener("input", e => {
      state.search = e.target.value;
      renderMenu();
    });

    categoryFilters.addEventListener("click", e => {
      const chip = e.target.closest("[data-category]");
      if(!chip) return;
      state.category = chip.dataset.category;
      renderCategories();
      renderMenu();
    });

    menuGrid.addEventListener("click", e => {
      const btn = e.target.closest("[data-add]");
      if(!btn) return;
      addToCart(Number(btn.dataset.add));
    });

    cartItems.addEventListener("click", e => {
      const btn = e.target.closest("[data-qty]");
      if(!btn) return;
      changeQty(Number(btn.dataset.id), Number(btn.dataset.qty));
    });

    authArea.addEventListener("click", e => {
      if(e.target.closest("#openAuthBtn")) openAuth("login");
      if(e.target.closest("#logoutBtn")){
        state.currentUser = null;
        persist();
        renderAuthArea();
        renderOrders();
        toast("Logged out successfully");
      }
      if(e.target.closest("#ordersShortcut")){
        document.getElementById("orders").scrollIntoView({ behavior:"smooth" });
      }
    });

    cartButton.addEventListener("click", openDrawer);
    heroCartBtn.addEventListener("click", openDrawer);
    checkoutButton.addEventListener("click", openCheckout);
    overlay.addEventListener("click", closeAll);

    document.querySelectorAll("[data-close]").forEach(btn => {
      btn.addEventListener("click", closeAll);
    });

    tabs.forEach(btn => btn.addEventListener("click", () => switchTab(btn.dataset.tab)));

    loginForm.addEventListener("submit", e => {
      e.preventDefault();
      const email = document.getElementById("loginEmail").value.trim().toLowerCase();
      const password = document.getElementById("loginPassword").value.trim();
      const user = state.users.find(u => u.email === email && u.password === password);
      if(!user) return toast("Invalid email or password.");
      state.currentUser = { name:user.name, email:user.email };
      persist();
      renderAuthArea();
      renderOrders();
      toast("Logged in successfully");
      authModal.classList.remove("open");
      updateOverlay();
      loginForm.reset();
      if(checkoutAfterAuth){
        checkoutAfterAuth = false;
        openCheckout();
      }
    });

    registerForm.addEventListener("submit", e => {
      e.preventDefault();
      const name = document.getElementById("registerName").value.trim();
      const email = document.getElementById("registerEmail").value.trim().toLowerCase();
      const password = document.getElementById("registerPassword").value.trim();
      if(state.users.some(u => u.email === email)) return toast("This email is already registered.");
      const user = { name, email, password };
      state.users.push(user);
      state.currentUser = { name, email };
      persist();
      renderAuthArea();
      renderOrders();
      toast("Account created successfully");
      registerForm.reset();
      authModal.classList.remove("open");
      updateOverlay();
      if(checkoutAfterAuth){
        checkoutAfterAuth = false;
        openCheckout();
      }
    });

    document.getElementById("paymentOptions").addEventListener("click", e => {
      const label = e.target.closest(".radio");
      if(!label) return;
      document.querySelectorAll(".radio").forEach(r => r.classList.remove("active"));
      label.classList.add("active");
      label.querySelector("input").checked = true;
    });

    checkoutForm.addEventListener("submit", e => {
      e.preventDefault();
      if(!state.currentUser) return openAuth("login");
      const name = document.getElementById("checkoutName").value.trim();
      const email = document.getElementById("checkoutEmail").value.trim().toLowerCase();
      const phone = document.getElementById("checkoutPhone").value.trim();
      const city = document.getElementById("checkoutCity").value.trim();
      const address = document.getElementById("checkoutAddress").value.trim();
      const payment = document.querySelector('input[name="payment"]:checked').value;
      if(!name || !email || !phone || !city || !address) return toast("Please complete all checkout fields.");

      const totals = getCartTotals();
      const items = state.cart.map(entry => {
        const item = menuData.find(i => i.id === entry.id);
        return { id:item.id, name:item.name, qty:entry.qty, price:item.price };
      });

      const order = {
        orderNo: "QB-" + Date.now().toString().slice(-6),
        name, email, phone, city, address, payment,
        items,
        subtotal: totals.subtotal,
        total: totals.total,
        createdAt: new Date().toISOString()
      };

      state.orders.unshift(order);
      state.cart = [];
      persist();
      renderCart();
      renderOrders();
      checkoutModal.classList.remove("open");
      updateOverlay();
      checkoutForm.reset();
      openSuccess(`Order ${order.orderNo} confirmed. Delivery to ${city} in about 25–35 minutes.`);
    });

    viewOrdersBtn.addEventListener("click", () => {
      closeAll();
      document.getElementById("orders").scrollIntoView({ behavior:"smooth" });
    });

    window.addEventListener("keydown", e => {
      if(e.key === "Escape") closeAll();
    });
  </script>
</body>
</html>
