// Initialize AOS animations
AOS.init({
    duration: 800,
    easing: 'ease-in-out',
    once: true,
    offset: 100
});

// Loading Screen
window.addEventListener('load', function() {
    const loadingScreen = document.getElementById('loading-screen');
    setTimeout(() => {
        loadingScreen.classList.add('hidden');
        setTimeout(() => {
            loadingScreen.style.display = 'none';
        }, 500);
    }, 1500);
});

// DOM Elements
const startAppBtn = document.getElementById('start-app-btn');
const backToHomeBtn = document.getElementById('back-to-home-btn');
const mainAppSection = document.getElementById('main-app-section');
const specialtyDropdown = document.getElementById('specialty-dropdown');
const getQuestionsBtn = document.getElementById('get-questions-btn');
const questionsForm = document.getElementById('questions-form');
const submitAnswersBtn = document.getElementById('submit-answers-btn');
const startOverBtn = document.getElementById('start-over-btn');
const loadingSpinner = document.getElementById('loading-spinner');
const specialtyError = document.getElementById('specialty-error');
const answersError = document.getElementById('answers-error');
const majorSuggestions = document.getElementById('major-suggestions');
const emailContact = document.getElementById('email-contact');
const backToTopBtn = document.getElementById('back-to-top');

// Initialize Charts
function initializeCharts() {
    // Accuracy Chart
    const accuracyCtx = document.getElementById('accuracyChart');
    if (accuracyCtx) {
        new Chart(accuracyCtx, {
            type: 'doughnut',
            data: {
                labels: ['دقة عالية', 'دقة متوسطة', 'دقة منخفضة'],
                datasets: [{
                    data: [85, 10, 5],
                    backgroundColor: [
                        '#22C55E',
                        '#F59E0B',
                        '#EF4444'
                    ],
                    borderWidth: 0
                }]
            },
            options: {
                responsive: true,
                maintainAspectRatio: false,
                plugins: {
                    legend: {
                        position: 'bottom',
                        labels: {
                            padding: 20,
                            usePointStyle: true
                        }
                    }
                }
            }
        });
    }
}

// Progress Circles Animation
function animateProgressCircles() {
    const circles = document.querySelectorAll('.progress-circle');
    circles.forEach(circle => {
        const progress = circle.getAttribute('data-progress');
        const percentage = (progress / 100) * 360;
        circle.style.background = `conic-gradient(var(--primary) 0deg, var(--primary) ${percentage}deg, #E5E7EB ${percentage}deg)`;
    });
}



// Back to Top Button
window.addEventListener('scroll', function() {
    if (window.pageYOffset > 300) {
        backToTopBtn.classList.add('show');
    } else {
        backToTopBtn.classList.remove('show');
    }
});

backToTopBtn.addEventListener('click', function() {
    window.scrollTo({
        top: 0,
        behavior: 'smooth'
    });
});

// FAQ Toggle Functionality
document.addEventListener('DOMContentLoaded', function() {
    // FAQ Toggle
    const faqItems = document.querySelectorAll('.faq-item');
    faqItems.forEach(item => {
        const question = item.querySelector('.faq-question');
        question.addEventListener('click', () => {
            const isActive = item.classList.contains('active');
            
            // Close all FAQ items
            faqItems.forEach(faqItem => {
                faqItem.classList.remove('active');
            });
            
            // Open clicked item if it wasn't active
            if (!isActive) {
                item.classList.add('active');
            }
        });
    });

    // Smooth scrolling for navigation links
    const navLinks = document.querySelectorAll('.nav-menu a[href^="#"]');
    navLinks.forEach(link => {
        link.addEventListener('click', function(e) {
            e.preventDefault();
            const targetId = this.getAttribute('href');
            const targetSection = document.querySelector(targetId);
            
            if (targetSection) {
                const offsetTop = targetSection.offsetTop - 80; // Account for fixed nav
                window.scrollTo({
                    top: offsetTop,
                    behavior: 'smooth'
                });
            }
        });
    });

    // Statistics Counter Animation
    const statNumbers = document.querySelectorAll('.stat-number[data-count]');
    const observerOptions = {
        threshold: 0.5,
        rootMargin: '0px 0px -100px 0px'
    };

    const observer = new IntersectionObserver((entries) => {
        entries.forEach(entry => {
            if (entry.isIntersecting) {
                const target = entry.target;
                const count = parseInt(target.getAttribute('data-count'));
                animateCounter(target, count);
                observer.unobserve(target);
            }
        });
    }, observerOptions);

    statNumbers.forEach(stat => {
        observer.observe(stat);
    });

    // Copy email functionality
    if (emailContact) {
        emailContact.addEventListener('click', function() {
            const email = this.textContent;
            navigator.clipboard.writeText(email).then(() => {
                showNotification('تم نسخ البريد الإلكتروني', 'success');
            }).catch(() => {
                showNotification('فشل في نسخ البريد الإلكتروني', 'error');
            });
        });
    }

    // Social links feedback
    const socialLinks = document.querySelectorAll('.support-item a');
    socialLinks.forEach(link => {
        link.addEventListener('click', function() {
            showNotification('جاري فتح الرابط...', 'info');
        });
    });

    // Initialize charts and animations
    initializeCharts();
    animateProgressCircles();
});

// Counter Animation Function
function animateCounter(element, target) {
    let current = 0;
    const increment = target / 100;
    const timer = setInterval(() => {
        current += increment;
        if (current >= target) {
            current = target;
            clearInterval(timer);
        }
        element.textContent = Math.floor(current) + (target >= 1000 ? '+' : '');
    }, 20);
}

// Notification System
function showNotification(message, type = 'info') {
    const notification = document.createElement('div');
    notification.className = `notification notification-${type}`;
    notification.innerHTML = `
        <i class="material-icons">${type === 'success' ? 'check_circle' : type === 'error' ? 'error' : 'info'}</i>
        <span>${message}</span>
    `;
    
    document.body.appendChild(notification);
    
    // Animate in
    setTimeout(() => {
        notification.classList.add('show');
    }, 100);
    
    // Remove after 3 seconds
    setTimeout(() => {
        notification.classList.remove('show');
        setTimeout(() => {
            document.body.removeChild(notification);
        }, 300);
    }, 3000);
}

// Navigation Functions
startAppBtn.addEventListener('click', () => {
    // Hide all landing page sections
    document.querySelectorAll('.hero-section, .features-section, .advanced-features-section, .stats-section, .how-it-works-section, .testimonials-section, .faq-section, .support-section, .app-info-section, .footer').forEach(section => {
        section.style.display = 'none';
    });
    
    // Show main app section
    mainAppSection.style.display = 'block';
    
    // Smooth scroll to top
    window.scrollTo({
        top: 0,
        behavior: 'smooth'
    });
});

backToHomeBtn.addEventListener('click', () => {
    // Show all landing page sections
    document.querySelectorAll('.hero-section, .features-section, .advanced-features-section, .stats-section, .how-it-works-section, .testimonials-section, .faq-section, .support-section, .app-info-section, .footer').forEach(section => {
        section.style.display = 'block';
    });
    
    // Hide main app section
    mainAppSection.style.display = 'none';
    
    // Reset form
    resetForm();
    
    // Smooth scroll to top
    window.scrollTo({
        top: 0,
        behavior: 'smooth'
    });
});

// Form Functions
function resetForm() {
    specialtyDropdown.value = '';
    questionsForm.innerHTML = '';
    specialtyError.textContent = '';
    answersError.textContent = '';
    majorSuggestions.innerHTML = '';
    
    // Hide sections
    document.getElementById('specialty-selection').style.display = 'block';
    document.getElementById('questions-section').style.display = 'none';
    document.getElementById('suggestions-section').style.display = 'none';
    loadingSpinner.style.display = 'none';
}

// Get Questions
getQuestionsBtn.addEventListener('click', async () => {
    const specialty = specialtyDropdown.value;
    
    if (!specialty) {
        specialtyError.textContent = 'الرجاء اختيار تخصص.';
        return;
    }
    
    specialtyError.textContent = '';
    loadingSpinner.style.display = 'block';
    
    try {
        const response = await fetch('/get_questions', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json',
            },
            body: JSON.stringify({ specialty: specialty })
        });
        
        const data = await response.json();
        
        if (data.success) {
            displayQuestions(data.questions);
            document.getElementById('specialty-selection').style.display = 'none';
            document.getElementById('questions-section').style.display = 'block';
        } else {
            specialtyError.textContent = data.error || 'حدث خطأ في جلب الأسئلة.';
        }
    } catch (error) {
        specialtyError.textContent = 'حدث خطأ في الاتصال بالخادم.';
    } finally {
        loadingSpinner.style.display = 'none';
    }
});

// Display Questions
function displayQuestions(questions) {
    questionsForm.innerHTML = '';
    
    questions.forEach((question, index) => {
        const questionDiv = document.createElement('div');
        questionDiv.className = 'question-group';
        questionDiv.innerHTML = `
            <label for="question-${index}">${question}</label>
            <textarea id="question-${index}" name="question-${index}" rows="3" placeholder="اكتب إجابتك هنا..."></textarea>
        `;
        questionsForm.appendChild(questionDiv);
    });
}

// Submit Answers
submitAnswersBtn.addEventListener('click', async () => {
    const textareas = questionsForm.querySelectorAll('textarea');
    const answers = [];
    
    textareas.forEach((textarea, index) => {
        if (!textarea.value.trim()) {
            answersError.textContent = 'الرجاء الإجابة على جميع الأسئلة.';
            return;
        }
        answers.push({
            question: textarea.previousElementSibling.textContent,
            answer: textarea.value.trim()
        });
    });
    
    if (answers.length !== textareas.length) {
        return;
    }
    
    answersError.textContent = '';
    loadingSpinner.style.display = 'block';
    
    try {
        const response = await fetch('/get_suggestions', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json',
            },
            body: JSON.stringify({
                specialty: specialtyDropdown.value,
                answers: answers
            })
        });
        
        const data = await response.json();
        
        if (data.success) {
            displaySuggestions(data.suggestions);
            document.getElementById('questions-section').style.display = 'none';
            document.getElementById('suggestions-section').style.display = 'block';
        } else {
            answersError.textContent = data.error || 'حدث خطأ في جلب الاقتراحات.';
        }
    } catch (error) {
        answersError.textContent = 'حدث خطأ في الاتصال بالخادم.';
    } finally {
        loadingSpinner.style.display = 'none';
    }
});

// Display Suggestions
function displaySuggestions(suggestions) {
    majorSuggestions.innerHTML = '';
    
    suggestions.forEach(suggestion => {
        const suggestionDiv = document.createElement('div');
        suggestionDiv.className = 'suggestion-item';
        suggestionDiv.innerHTML = `
            <h3>${suggestion.title}</h3>
            <p>${suggestion.description}</p>
        `;
        majorSuggestions.appendChild(suggestionDiv);
    });
}

// Start Over
startOverBtn.addEventListener('click', () => {
    resetForm();
});

// Add CSS for notifications
const notificationStyles = document.createElement('style');
notificationStyles.textContent = `
    .notification {
        position: fixed;
        top: 100px;
        right: 20px;
        background: white;
        border-radius: 8px;
        padding: 16px 20px;
        box-shadow: 0 4px 12px rgba(0, 0, 0, 0.15);
        display: flex;
        align-items: center;
        gap: 12px;
        z-index: 10000;
        transform: translateX(400px);
        transition: transform 0.3s ease;
        border-right: 4px solid var(--primary);
    }
    
    .notification.show {
        transform: translateX(0);
    }
    
    .notification-success {
        border-right-color: var(--primary);
    }
    
    .notification-error {
        border-right-color: #EF4444;
    }
    
    .notification-info {
        border-right-color: #3B82F6;
    }
    
    .notification i {
        font-size: 20px;
    }
    
    .notification-success i {
        color: var(--primary);
    }
    
    .notification-error i {
        color: #EF4444;
    }
    
    .notification-info i {
        color: #3B82F6;
    }
    
    .notification span {
        font-weight: 500;
        color: var(--text-primary);
    }
`;

document.head.appendChild(notificationStyles);

// Enhanced hover effects for interactive elements
document.addEventListener('DOMContentLoaded', function() {
    // Add hover effects to feature items
    const featureItems = document.querySelectorAll('.feature-item');
    featureItems.forEach(item => {
        item.addEventListener('mouseenter', function() {
            this.style.transform = 'translateY(-8px) scale(1.02)';
        });
        
        item.addEventListener('mouseleave', function() {
            this.style.transform = 'translateY(0) scale(1)';
        });
    });

    // Add hover effects to stat cards
    const statCards = document.querySelectorAll('.stat-card');
    statCards.forEach(card => {
        card.addEventListener('mouseenter', function() {
            this.style.transform = 'translateY(-4px) scale(1.02)';
        });
        
        card.addEventListener('mouseleave', function() {
            this.style.transform = 'translateY(0) scale(1)';
        });
    });

    // Add hover effects to testimonial cards
    const testimonialCards = document.querySelectorAll('.testimonial-card');
    testimonialCards.forEach(card => {
        card.addEventListener('mouseenter', function() {
            this.style.transform = 'translateY(-4px) scale(1.01)';
        });
        
        card.addEventListener('mouseleave', function() {
            this.style.transform = 'translateY(0) scale(1)';
        });
    });


});

// Parallax effect for floating shapes
window.addEventListener('scroll', function() {
    const scrolled = window.pageYOffset;
    const shapes = document.querySelectorAll('.shape');
    
    shapes.forEach((shape, index) => {
        const speed = 0.5 + (index * 0.1);
        shape.style.transform = `translateY(${scrolled * speed}px) rotate(${scrolled * 0.1}deg)`;
    });
});

// Smooth reveal animations for sections
const revealSections = document.querySelectorAll('.features-section, .advanced-features-section, .stats-section, .how-it-works-section, .testimonials-section, .faq-section, .support-section, .app-info-section');

const revealSection = function(entries, observer) {
    entries.forEach(entry => {
        if (entry.isIntersecting) {
            entry.target.classList.add('section-revealed');
            observer.unobserve(entry.target);
        }
    });
};

const sectionObserver = new IntersectionObserver(revealSection, {
    root: null,
    threshold: 0.15,
});

revealSections.forEach(section => {
    sectionObserver.observe(section);
});

// Add CSS for section reveal animations
const revealStyles = document.createElement('style');
revealStyles.textContent = `
    .features-section,
    .advanced-features-section,
    .stats-section,
    .how-it-works-section,
    .testimonials-section,
    .faq-section,
    .support-section,
    .app-info-section {
        opacity: 0;
        transform: translateY(50px);
        transition: all 0.8s ease;
    }
    
    .section-revealed {
        opacity: 1;
        transform: translateY(0);
    }
`;

document.head.appendChild(revealStyles);

// Enhanced scroll effects
window.addEventListener('scroll', function() {
    const scrolled = window.pageYOffset;
    const parallaxElements = document.querySelectorAll('.hero-section, .features-section, .stats-section');
    
    parallaxElements.forEach(element => {
        const speed = 0.5;
        element.style.transform = `translateY(${scrolled * speed}px)`;
    });
});

// Add floating particles effect
function createParticles() {
    const particlesContainer = document.querySelector('.particles');
    if (!particlesContainer) return;
    
    for (let i = 0; i < 50; i++) {
        const particle = document.createElement('div');
        particle.className = 'particle';
        particle.style.cssText = `
            position: absolute;
            width: ${Math.random() * 4 + 2}px;
            height: ${Math.random() * 4 + 2}px;
            background: rgba(255, 255, 255, ${Math.random() * 0.5 + 0.2});
            border-radius: 50%;
            left: ${Math.random() * 100}%;
            top: ${Math.random() * 100}%;
            animation: float-particle ${Math.random() * 10 + 10}s linear infinite;
            animation-delay: ${Math.random() * 5}s;
        `;
        particlesContainer.appendChild(particle);
    }
}

// Add particle animation CSS
const particleStyles = document.createElement('style');
particleStyles.textContent = `
    @keyframes float-particle {
        0% {
            transform: translateY(100vh) rotate(0deg);
            opacity: 0;
        }
        10% {
            opacity: 1;
        }
        90% {
            opacity: 1;
        }
        100% {
            transform: translateY(-100px) rotate(360deg);
            opacity: 0;
        }
    }
    
    .particles {
        position: absolute;
        top: 0;
        left: 0;
        width: 100%;
        height: 100%;
        overflow: hidden;
        pointer-events: none;
    }
`;

document.head.appendChild(particleStyles);

// Initialize particles
document.addEventListener('DOMContentLoaded', function() {
    createParticles();
}); 
