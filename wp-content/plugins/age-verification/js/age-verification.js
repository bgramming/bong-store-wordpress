/**
 * Age Verification JavaScript
 */
(function($) {
    'use strict';
    
    $(document).ready(function() {
        const $birthYearInput = $('#birth_year');
        const $verifyBtn = $('#verify-age-btn');
        const $exitBtn = $('#exit-btn');
        const $errorDiv = $('.age-verification-error');
        const $form = $('.age-verification-form');
        
        // Focus on input
        $birthYearInput.focus();
        
        // Verify age button click
        $verifyBtn.on('click', function() {
            verifyAge();
        });
        
        // Enter key press
        $birthYearInput.on('keypress', function(e) {
            if (e.which === 13) { // Enter key
                e.preventDefault();
                verifyAge();
            }
        });
        
        // Exit button click
        $exitBtn.on('click', function() {
            showError();
        });
        
        /**
         * Verify user's age
         */
        function verifyAge() {
            const birthYear = parseInt($birthYearInput.val());
            const currentYear = new Date().getFullYear();
            const minimumAge = ageVerification.minimum_age;
            
            // Validate input
            if (!birthYear || birthYear < 1900 || birthYear > currentYear) {
                alert('Please enter a valid birth year');
                $birthYearInput.focus();
                return;
            }
            
            // Calculate age
            const age = currentYear - birthYear;
            
            // Check if old enough
            if (age < minimumAge) {
                showError();
                return;
            }
            
            // Disable button
            $verifyBtn.prop('disabled', true).text('Verifying...');
            
            // Send AJAX request
            $.ajax({
                url: ageVerification.ajaxurl,
                type: 'POST',
                data: {
                    action: 'verify_age',
                    birth_year: birthYear,
                    nonce: ageVerification.nonce
                },
                success: function(response) {
                    if (response.success) {
                        // Age verified - reload page
                        $verifyBtn.text('✓ Verified!');
                        setTimeout(function() {
                            location.reload();
                        }, 500);
                    } else {
                        showError();
                    }
                },
                error: function() {
                    alert('An error occurred. Please try again.');
                    $verifyBtn.prop('disabled', false).text('I am ' + minimumAge + '+');
                }
            });
        }
        
        /**
         * Show error message
         */
        function showError() {
            $form.fadeOut(300, function() {
                $errorDiv.fadeIn(300);
            });
            
            // Optionally redirect after showing error
            setTimeout(function() {
                window.location.href = 'https://www.google.com';
            }, 3000);
        }
    });
    
})(jQuery);

