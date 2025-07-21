// Initialize AOS animations
AOS.init({
    duration: 600,
    easing: 'ease-out',
    once: true,
    offset: 50,
    delay: 0
});

// Loading Screen
window.addEventListener('load', function() {
    const loadingScreen = document.getElementById('loading-screen');
    setTimeout(() => {
        loadingScreen.classList.add('hidden');
        setTimeout(() => {
            loadingScreen.style.display = 'none';
        }, 300);
    }, 800);
});

// DOM Elements
const startAppBtn = document.getElementById('start-app-btn');
const backToHomeBtn = document.getElementById('back-to-home-btn');
const mainAppSection = document.getElementById('main-app-section');
const getQuestionsBtn = document.getElementById('get-questions-btn');
const questionsContainer = document.getElementById('questions-container');
const startOverBtn = document.getElementById('start-over-btn');
const loadingSpinner = document.getElementById('loading-spinner');
const specialtyError = document.getElementById('specialty-error');
const answersError = document.getElementById('answers-error');
const majorSuggestions = document.getElementById('major-suggestions');
const emailContact = document.getElementById('email-contact');
const backToTopBtn = document.getElementById('back-to-top');

// App State
let selectedSpecialty = '';
let currentQuestions = [];
let currentQuestionIndex = 0;
let userAnswers = {};







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


    
    // Specialty selection
    const specialtyOptions = document.querySelectorAll('.specialty-option');
    specialtyOptions.forEach(option => {
        option.addEventListener('click', function() {
            // Remove selection from all options
            specialtyOptions.forEach(opt => opt.classList.remove('selected'));
            
            // Select clicked option
            this.classList.add('selected');
            
            // Update selected specialty
            selectedSpecialty = this.getAttribute('data-value');
            
            // Enable start button
            getQuestionsBtn.disabled = false;
            getQuestionsBtn.textContent = `ابدأ الاختبار - ${this.querySelector('h4').textContent}`;
            
            // Clear error
            specialtyError.textContent = '';
        });
    });
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
    // Reset specialty selection
    selectedSpecialty = '';
    currentQuestions = [];
    currentQuestionIndex = 0;
    userAnswers = {};
    
    // Clear specialty selection
    document.querySelectorAll('.specialty-option').forEach(opt => opt.classList.remove('selected'));
    getQuestionsBtn.disabled = true;
    getQuestionsBtn.textContent = 'ابدأ الاختبار';
    
    // Clear errors
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
    if (!selectedSpecialty) {
        specialtyError.textContent = 'الرجاء اختيار تخصص.';
        return;
    }
    
    specialtyError.textContent = '';
    loadingSpinner.style.display = 'block';
    
    try {
        const response = await fetch('https://wojhati.onrender.com/', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json',
            },
            body: JSON.stringify({ specialty: selectedSpecialty })
        });
        console.log('Raw response:', response);
        const data = await response.json();
        console.log('Parsed data:', data);
        
        if (data.success) {
            currentQuestions = data.questions;
            currentQuestionIndex = 0;
            userAnswers = {};
            displayCurrentQuestion();
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

// Display Current Question
function displayCurrentQuestion() {
    if (currentQuestionIndex >= currentQuestions.length) {
        submitAnswers();
        return;
    }
    
    const question = currentQuestions[currentQuestionIndex];
    const progress = ((currentQuestionIndex + 1) / currentQuestions.length) * 100;
    
    // Update progress
    document.querySelector('.progress-fill').style.width = `${progress}%`;
    document.getElementById('current-question').textContent = currentQuestionIndex + 1;
    document.getElementById('total-questions').textContent = currentQuestions.length;
    
    // Update navigation buttons
    const prevBtn = document.getElementById('prev-question-btn');
    const nextBtn = document.getElementById('next-question-btn');
    
    prevBtn.disabled = currentQuestionIndex === 0;
    
    if (currentQuestionIndex === currentQuestions.length - 1) {
        nextBtn.innerHTML = 'إنشاء الاقتراحات <i class="material-icons">send</i>';
    } else {
        nextBtn.innerHTML = 'التالي <i class="material-icons">arrow_forward</i>';
    }
    
    // Display question
    questionsContainer.innerHTML = `
        <div class="question-container">
            <div class="question-text">${question}</div>
            <div class="answer-options">
                <div class="answer-option" data-answer="نعم">
                    <div class="option-radio"></div>
                    <span>نعم</span>
                </div>
                <div class="answer-option" data-answer="غير متأكد">
                    <div class="option-radio"></div>
                    <span>غير متأكد</span>
                </div>
                <div class="answer-option" data-answer="لا">
                    <div class="option-radio"></div>
                    <span>لا</span>
                </div>
            </div>
        </div>
    `;
    
    // Add click handlers for answer options
    const answerOptions = document.querySelectorAll('.answer-option');
    answerOptions.forEach(option => {
        option.addEventListener('click', function() {
            // Remove selection from all options
            answerOptions.forEach(opt => opt.classList.remove('selected'));
            
            // Select clicked option
            this.classList.add('selected');
            
            // Store answer
            userAnswers[currentQuestionIndex] = this.getAttribute('data-answer');
            
            // Enable next button
            nextBtn.disabled = false;
        });
    });
    
    // Pre-select if user already answered
    if (userAnswers[currentQuestionIndex]) {
        const selectedOption = document.querySelector(`[data-answer="${userAnswers[currentQuestionIndex]}"]`);
        if (selectedOption) {
            selectedOption.classList.add('selected');
            nextBtn.disabled = false;
        }
    } else {
        nextBtn.disabled = true;
    }
}

// Navigation Buttons
document.addEventListener('DOMContentLoaded', function() {
    const prevBtn = document.getElementById('prev-question-btn');
    const nextBtn = document.getElementById('next-question-btn');
    
    prevBtn.addEventListener('click', () => {
        if (currentQuestionIndex > 0) {
            currentQuestionIndex--;
            displayCurrentQuestion();
        }
    });
    
    nextBtn.addEventListener('click', () => {
        if (currentQuestionIndex < currentQuestions.length - 1) {
            currentQuestionIndex++;
            displayCurrentQuestion();
        } else {
            submitAnswers();
        }
    });
});

// Submit Answers
async function submitAnswers() {
    // Check if all questions are answered
    const unansweredQuestions = currentQuestions.filter((_, index) => !userAnswers[index]);
    
    if (unansweredQuestions.length > 0) {
        answersError.textContent = 'الرجاء الإجابة على جميع الأسئلة قبل الإرسال.';
        return;
    }
    
    answersError.textContent = '';
    loadingSpinner.style.display = 'block';
    
    try {
        const answers = currentQuestions.map((question, index) => ({
            question: question,
            answer: userAnswers[index]
        }));
        
        const response = await fetch('https://wojhati.onrender.com/', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json',
            },
            body: JSON.stringify({
                specialty: selectedSpecialty,
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
}

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



 
