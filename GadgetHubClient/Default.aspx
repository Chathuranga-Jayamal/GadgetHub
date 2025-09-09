<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="GadgetHubClient.Default" %>
<%@ Register Src="~/Controls/NavigationBar.ascx" TagPrefix="uc" TagName="NavigationBar" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>The Gadget Hub – Smarter Gadget Shopping</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet"/>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;800&display=swap" rel="stylesheet"/>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet"/>
    <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet"/>
    <style>
        :root {
            --primary-gradient: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            --secondary-gradient: linear-gradient(135deg, #f093fb 0%, #f5576c 100%);
            --accent-gradient: linear-gradient(135deg, #4facfe 0%, #00f2fe 100%);
            --dark-gradient: linear-gradient(135deg, #0c0c0c 0%, #1a1a1a 100%);
            --glass-bg: rgba(255, 255, 255, 0.1);
            --glass-border: rgba(255, 255, 255, 0.2);
        }

        * { box-sizing: border-box; }
        body { 
            font-family: 'Inter', sans-serif; 
            background: #0a0a0a; 
            color: #ffffff; 
            line-height: 1.6; 
            overflow-x: hidden;
        }

        /* Animated Background */
        .animated-bg {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            z-index: -1;
            background: linear-gradient(45deg, #0a0a0a, #1a1a2e, #16213e, #0f3460);
            background-size: 400% 400%;
            animation: gradientShift 15s ease infinite;
        }

        @keyframes gradientShift {
            0% { background-position: 0% 50%; }
            50% { background-position: 100% 50%; }
            100% { background-position: 0% 50%; }
        }

        /* Floating Particles */
        .particles {
            position: absolute;
            width: 100%;
            height: 100%;
            overflow: hidden;
        }

        .particle {
            position: absolute;
            background: rgba(255, 255, 255, 0.1);
            border-radius: 50%;
            animation: float 6s ease-in-out infinite;
        }

        @keyframes float {
            0%, 100% { transform: translateY(0px) rotate(0deg); }
            50% { transform: translateY(-20px) rotate(180deg); }
        }

        /* Glass Morphism Effects */
        .glass-card {
            background: var(--glass-bg);
            backdrop-filter: blur(20px);
            border: 1px solid var(--glass-border);
            border-radius: 20px;
            padding: 2rem;
            transition: all 0.4s ease;
        }

        .glass-card:hover {
            background: rgba(255, 255, 255, 0.15);
            transform: translateY(-8px);
            box-shadow: 0 20px 40px rgba(0, 0, 0, 0.3);
        }

        /* Hero Section */
        .hero-section {
            position: relative;
            min-height: 80vh;
            display: flex;
            align-items: center;
            justify-content: center;
            text-align: center;
            padding: 2rem;
            background: var(--primary-gradient);
            overflow: hidden;
        }

        .hero-content {
            max-width: 800px;
            z-index: 2;
            animation: fadeInUp 1s ease-out;
        }

        .hero-section h1 {
            font-size: clamp(2.5rem, 6vw, 4.5rem);
            font-weight: 800;
            margin-bottom: 1.5rem;
            background: linear-gradient(45deg, #fff, #f0f9ff, #e0f2fe);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            text-shadow: 0 4px 8px rgba(0, 0, 0, 0.3);
        }

        .hero-section p {
            font-size: 1.4rem;
            margin-bottom: 3rem;
            opacity: 0.95;
            line-height: 1.8;
        }

        .hero-btn {
            background: var(--accent-gradient);
            color: white;
            padding: 1.2rem 3rem;
            border-radius: 50px;
            font-weight: 600;
            text-decoration: none;
            display: inline-block;
            transition: all 0.3s ease;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.3);
            position: relative;
            overflow: hidden;
        }

        .hero-btn::before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg, transparent, rgba(255,255,255,0.3), transparent);
            transition: left 0.5s;
        }

        .hero-btn:hover::before {
            left: 100%;
        }

        .hero-btn:hover {
            transform: translateY(-3px);
            box-shadow: 0 15px 40px rgba(0, 0, 0, 0.4);
            color: white;
        }

        @keyframes fadeInUp {
            from { opacity: 0; transform: translateY(30px); }
            to { opacity: 1; transform: translateY(0); }
        }

        /* Sections */
        .modern-section {
            padding: 6rem 2rem;
            position: relative;
        }

        .section-title {
            font-weight: 700;
            font-size: clamp(2rem, 4vw, 3rem);
            margin-bottom: 1.5rem;
            text-align: center;
            background: var(--accent-gradient);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
        }

        .section-subtitle {
            color: #b0b0b0;
            text-align: center;
            max-width: 600px;
            margin: 0 auto 4rem;
            font-size: 1.2rem;
            line-height: 1.7;
        }

        /* Grid Layouts */
        .modern-grid {
            display: grid;
            gap: 3rem;
            grid-template-columns: repeat(auto-fit, minmax(320px, 1fr));
            max-width: 1200px;
            margin: 0 auto;
        }

        /* How It Works Grid - 3 cards for desktop */
        .process-grid {
            display: grid;
            gap: 2.5rem;
            grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
            max-width: 1100px;
            margin: 0 auto;
        }

        @media (min-width: 992px) {
            .process-grid {
                grid-template-columns: repeat(3, 1fr);
            }
        }

        /* Step Cards */
        .step-card {
            position: relative;
            text-align: center;
            padding: 2.5rem 1.5rem;
            transition: all 0.4s ease;
        }

        .step-number {
            position: absolute;
            top: -15px;
            right: 20px;
            background: var(--secondary-gradient);
            color: white;
            width: 40px;
            height: 40px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-weight: 700;
            font-size: 1.1rem;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.3);
        }

        .step-icon {
            font-size: 4rem;
            margin-bottom: 1.5rem;
            background: var(--accent-gradient);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            display: block;
        }

        .material-icons.step-icon {
            background: var(--accent-gradient);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
        }

        /* Feature Cards */
        .feature-card {
            position: relative;
            overflow: hidden;
            transition: all 0.4s ease;
        }

        .feature-icon {
            font-size: 3.5rem;
            margin-bottom: 1.5rem;
            background: var(--secondary-gradient);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            display: block;
        }

        .feature-card h5 {
            font-size: 1.5rem;
            font-weight: 600;
            margin-bottom: 1rem;
            color: #ffffff;
        }

        .feature-card p {
            color: #b0b0b0;
            line-height: 1.6;
        }

        /* Product Cards */
        .product-card {
            background: var(--glass-bg);
            backdrop-filter: blur(20px);
            border: 1px solid var(--glass-border);
            border-radius: 20px;
            overflow: hidden;
            transition: all 0.4s ease;
            position: relative;
        }

        .product-card:hover {
            transform: translateY(-10px) scale(1.02);
            box-shadow: 0 25px 50px rgba(0, 0, 0, 0.4);
        }

        .product-card img {
            width: 100%;
            height: 250px;
            object-fit: cover;
            transition: transform 0.4s ease;
        }

        .product-card:hover img {
            transform: scale(1.1);
        }

        .product-card-body {
            padding: 1.5rem;
        }

        .product-card-body h5 {
            font-weight: 600;
            margin-bottom: 0.5rem;
            color: #ffffff;
        }

        .product-price {
            background: var(--accent-gradient);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            font-weight: 700;
            font-size: 1.3rem;
        }

        /* Testimonial Cards */
        .testimonial-card {
            text-align: center;
            position: relative;
        }

        .testimonial-avatar {
            width: 80px;
            height: 80px;
            border-radius: 50%;
            margin: 0 auto 1.5rem;
            background: var(--accent-gradient);
            color: white;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 2rem;
            font-weight: bold;
            border: 3px solid rgba(255, 255, 255, 0.2);
            transition: transform 0.3s ease;
        }

        .testimonial-card:hover .testimonial-avatar {
            transform: scale(1.1);
        }

        .testimonial-text {
            font-style: italic;
            font-size: 1.1rem;
            color: #e0e0e0;
            margin-bottom: 1rem;
            line-height: 1.6;
        }

        .testimonial-name {
            color: #b0b0b0;
            font-weight: 500;
        }

        /* CTA Section */
        .cta-section {
            background: var(--dark-gradient);
            padding: 5rem 2rem;
            text-align: center;
            position: relative;
            overflow: hidden;
        }

        .cta-section::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: url('data:image/svg+xml,<svg width="60" height="60" viewBox="0 0 60 60" xmlns="http://www.w3.org/2000/svg"><g fill="none" fill-rule="evenodd"><g fill="%23ffffff" fill-opacity="0.05"><circle cx="30" cy="30" r="2"/></g></svg>');
            opacity: 0.3;
        }

        .cta-content {
            position: relative;
            z-index: 2;
            max-width: 600px;
            margin: 0 auto;
        }

        .cta-section h2 {
            font-size: clamp(2rem, 4vw, 3.5rem);
            font-weight: 700;
            margin-bottom: 1.5rem;
            background: var(--secondary-gradient);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
        }

        .cta-section p {
            font-size: 1.3rem;
            color: #b0b0b0;
            margin-bottom: 3rem;
            line-height: 1.6;
        }

        /* Footer */
        footer {
            background: #000000;
            color: #666;
            padding: 3rem 2rem;
            text-align: center;
            border-top: 1px solid rgba(255, 255, 255, 0.1);
        }

        /* Scroll Animations */
        .fade-in {
            opacity: 0;
            transform: translateY(30px);
            transition: all 0.8s ease;
        }

        .fade-in.visible {
            opacity: 1;
            transform: translateY(0);
        }

        /* Mobile Responsiveness */
        @media (max-width: 768px) {
            .modern-grid {
                grid-template-columns: 1fr;
                gap: 2rem;
            }
            
            .modern-section {
                padding: 4rem 1rem;
            }
            
            .hero-section {
                padding: 1rem;
            }
        }

        /* Hover Effects */
        .hover-glow:hover {
            box-shadow: 0 0 30px rgba(102, 126, 234, 0.5);
        }

        /* Loading Animation */
        .loading-animation {
            animation: pulse 2s ease-in-out infinite;
        }

        @keyframes pulse {
            0%, 100% { opacity: 1; }
            50% { opacity: 0.7; }
        }
    </style>
</head>
<body>
    <div class="animated-bg"></div>
    
    <form id="form1" runat="server">
        <uc:NavigationBar runat="server" ID="NavigationBar" />

        <!-- Hero Section -->
        <section class="hero-section">
            <div class="particles">
                <div class="particle" style="left: 20%; top: 20%; width: 8px; height: 8px; animation-delay: 0s;"></div>
                <div class="particle" style="left: 80%; top: 30%; width: 6px; height: 6px; animation-delay: 1s;"></div>
                <div class="particle" style="left: 60%; top: 70%; width: 10px; height: 10px; animation-delay: 2s;"></div>
                <div class="particle" style="left: 40%; top: 80%; width: 4px; height: 4px; animation-delay: 3s;"></div>
            </div>
            <div class="hero-content">
                <h1>Welcome to The Gadget Hub</h1>
                <p>Experience the future of gadget shopping with AI-powered price comparison, lightning-fast delivery, and cutting-edge technology at your fingertips.</p>
                <asp:HyperLink runat="server" NavigateUrl="~/Customer/BrowseProducts.aspx" CssClass="hero-btn">
                    <i class="fas fa-rocket"></i> Start Your Journey
                </asp:HyperLink>
            </div>
        </section>

        <!-- Features Section -->
        <section class="modern-section">
            <h2 class="section-title">Why Choose The Gadget Hub?</h2>
            <p class="section-subtitle">Revolutionary technology meets unbeatable service. We're redefining how you discover and purchase the latest gadgets.</p>
            <div class="modern-grid">
                <div class="glass-card feature-card fade-in hover-glow">
                    <i class="fas fa-brain feature-icon"></i>
                    <h5>AI-Powered Price Matching</h5>
                    <p>Our advanced algorithms instantly analyze prices across multiple distributors, ensuring you get the absolute best deal every single time.</p>
                </div>
                <div class="glass-card feature-card fade-in hover-glow">
                    <i class="fas fa-bolt feature-icon"></i>
                    <h5>Lightning-Fast Processing</h5>
                    <p>Orders processed in milliseconds with real-time inventory tracking and automated fulfillment from the most efficient source.</p>
                </div>
                <div class="glass-card feature-card fade-in hover-glow">
                    <i class="fas fa-shipping-fast feature-icon"></i>
                    <h5>Quantum Delivery Network</h5>
                    <p>Direct shipping from distributor to your door with predictive logistics and same-day delivery in major cities.</p>
                </div>
            </div>
        </section>

        <!-- How It Works -->
        <section class="modern-section" style="background: rgba(255, 255, 255, 0.02);">
            <h2 class="section-title">How The Magic Happens</h2>
            <p class="section-subtitle">Our revolutionary 3-step process combines cutting-edge technology with seamless user experience.</p>
            <div class="process-grid">
                <div class="glass-card step-card fade-in hover-glow">
                    <div class="step-number">1</div>
                    <span class="material-icons step-icon">shopping_cart</span>
                    <h5>Smart Order Placement</h5>
                    <p>Browse our curated selection and place your order through our intuitive, AI-enhanced interface with personalized recommendations.</p>
                </div>
                <div class="glass-card step-card fade-in hover-glow">
                    <div class="step-number">2</div>
                    <span class="material-icons step-icon">analytics</span>
                    <h5>AI Market Analysis</h5>
                    <p>Our advanced algorithms instantly query multiple distributors, analyzing real-time pricing, availability, and delivery options to find your perfect match.</p>
                </div>
                <div class="glass-card step-card fade-in hover-glow">
                    <div class="step-number">3</div>
                    <span class="material-icons step-icon">local_shipping</span>
                    <h5>Lightning Delivery</h5>
                    <p>Your order ships directly from the optimal distributor to your doorstep with real-time tracking and guaranteed satisfaction.</p>
                </div>
            </div>
        </section>

        <!-- Featured Products -->
        <section class="modern-section">
            <h2 class="section-title">Trending Now</h2>
            <p class="section-subtitle">Discover the hottest gadgets that are revolutionizing the tech world.</p>
            <div class="modern-grid">
                <div class="product-card fade-in">
                    <img src="./Images/earbuds.jpg" alt="Wireless Earbuds">
                    <div class="product-card-body">
                        <h5>Premium Wireless Earbuds</h5>
                        <p class="product-price">From $99</p>
                    </div>
                </div>
                <div class="product-card fade-in">
                    <img src="./Images/smartwatch.jpg" alt="Smart Watch">
                    <div class="product-card-body">
                        <h5>Next-Gen Smart Watch</h5>
                        <p class="product-price">From $149</p>
                    </div>
                </div>
                <div class="product-card fade-in">
                    <img src="./Images/camera.jpg" alt="Action Camera">
                    <div class="product-card-body">
                        <h5>4K Action Camera Pro</h5>
                        <p class="product-price">From $199</p>
                    </div>
                </div>
                <div class="product-card fade-in">
                    <img src="https://cdn.pixabay.com/photo/2018/09/17/14/27/headphones-3683983_960_720.jpg" alt="Gaming Headset">
                    <div class="product-card-body">
                        <h5>Pro Gaming Headset</h5>
                        <p class="product-price">From $129</p>
                    </div>
                </div>
                <div class="product-card fade-in">
                    <img src="https://cdn.pixabay.com/photo/2016/12/09/11/33/smartphone-1894723_960_720.jpg" alt="Smartphone">
                    <div class="product-card-body">
                        <h5>Latest Smartphone</h5>
                        <p class="product-price">From $699</p>
                    </div>
                </div>
                <div class="product-card fade-in">
                    <img src="./Images/laptop.jpg" alt="Laptop">
                    <div class="product-card-body">
                        <h5>Ultra-Thin Laptop</h5>
                        <p class="product-price">From $899</p>
                    </div>
                </div>
            </div>
        </section>

        <!-- Testimonials -->
        <section class="modern-section" style="background: rgba(255, 255, 255, 0.02);">
            <h2 class="section-title">What Our Community Says</h2>
            <div class="modern-grid">
                <div class="glass-card testimonial-card fade-in">
                    <div class="testimonial-avatar">AR</div>
                    <p class="testimonial-text">"Incredible experience! Got my dream setup delivered in 24 hours and saved over $200 compared to other retailers."</p>
                    <div class="testimonial-name">- Alex Rodriguez</div>
                </div>
                <div class="glass-card testimonial-card fade-in">
                    <div class="testimonial-avatar">SW</div>
                    <p class="testimonial-text">"The AI-powered recommendations were spot-on. Found gadgets I didn't even know I needed!"</p>
                    <div class="testimonial-name">- Sarah Williams</div>
                </div>
                <div class="glass-card testimonial-card fade-in">
                    <div class="testimonial-avatar">MT</div>
                    <p class="testimonial-text">"Revolutionary platform! The price matching is real - saved me $150 on my new smartphone purchase."</p>
                    <div class="testimonial-name">- Mark Thompson</div>
                </div>
            </div>
        </section>

        <!-- CTA Section -->
        <section class="cta-section">
            <div class="cta-content">
                <h2>Ready to Experience the Future?</h2>
                <p>Join thousands of satisfied customers who've discovered the smarter way to shop for gadgets.</p>
                <asp:HyperLink runat="server" NavigateUrl="~/Customer/BrowseProducts.aspx" CssClass="hero-btn">
                    <i class="fas fa-star"></i> Explore Now
                </asp:HyperLink>
            </div>
        </section>

        <!-- Footer -->
        <footer>
            <p>&copy; <%: DateTime.Now.Year %> The Gadget Hub. All rights reserved. | Powered by Innovation</p>
        </footer>
    </form>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // Scroll Animation
        const observerOptions = {
            threshold: 0.1,
            rootMargin: '0px 0px -50px 0px'
        };

        const observer = new IntersectionObserver(function(entries) {
            entries.forEach(entry => {
                if (entry.isIntersecting) {
                    entry.target.classList.add('visible');
                }
            });
        }, observerOptions);

        document.querySelectorAll('.fade-in').forEach(el => {
            observer.observe(el);
        });

        // Smooth scrolling
        document.querySelectorAll('a[href^="#"]').forEach(anchor => {
            anchor.addEventListener('click', function (e) {
                e.preventDefault();
                document.querySelector(this.getAttribute('href')).scrollIntoView({
                    behavior: 'smooth'
                });
            });
        });

        // Dynamic particle generation
        function createParticle() {
            const particle = document.createElement('div');
            particle.classList.add('particle');
            particle.style.left = Math.random() * 100 + '%';
            particle.style.top = Math.random() * 100 + '%';
            particle.style.width = (Math.random() * 8 + 2) + 'px';
            particle.style.height = particle.style.width;
            particle.style.animationDelay = Math.random() * 6 + 's';
            
            document.querySelector('.particles').appendChild(particle);
            
            setTimeout(() => {
                particle.remove();
            }, 6000);
        }

        // Generate particles periodically
        setInterval(createParticle, 3000);
    </script>
</body>
</html>