<?php
/**
 * Plugin Name: Age Verification for Bong Store
 * Plugin URI: https://github.com/bgramming/bong-store-wordpress
 * Description: Requires visitors to verify they are 18+ before accessing the site
 * Version: 1.0.0
 * Author: bgramming
 * Author URI: https://github.com/bgramming
 * License: GPL v2 or later
 * Text Domain: age-verification
 */

// Exit if accessed directly
if (!defined('ABSPATH')) {
    exit;
}

class BongStore_Age_Verification {
    
    private $cookie_name = 'bong_store_age_verified';
    private $cookie_duration = 30; // days
    
    public function __construct() {
        // Add age gate to frontend
        add_action('template_redirect', array($this, 'check_age_verification'));
        
        // Add admin menu
        add_action('admin_menu', array($this, 'add_admin_menu'));
        
        // Register settings
        add_action('admin_init', array($this, 'register_settings'));
        
        // Handle AJAX verification
        add_action('wp_ajax_nopriv_verify_age', array($this, 'verify_age'));
        add_action('wp_ajax_verify_age', array($this, 'verify_age'));
        
        // Enqueue scripts and styles
        add_action('wp_enqueue_scripts', array($this, 'enqueue_scripts'));
    }
    
    /**
     * Check if user has verified their age
     */
    public function check_age_verification() {
        // Skip for admin pages
        if (is_admin()) {
            return;
        }
        
        // Check if already verified
        if (isset($_COOKIE[$this->cookie_name]) && $_COOKIE[$this->cookie_name] === 'yes') {
            return;
        }
        
        // Show age gate
        $this->display_age_gate();
        exit;
    }
    
    /**
     * Display age verification gate
     */
    private function display_age_gate() {
        $minimum_age = get_option('age_verification_minimum_age', 18);
        $message = get_option('age_verification_message', 'You must be 18 years or older to enter this site.');
        $logo_url = get_option('age_verification_logo', get_site_icon_url());
        
        ?>
        <!DOCTYPE html>
        <html <?php language_attributes(); ?>>
        <head>
            <meta charset="<?php bloginfo('charset'); ?>">
            <meta name="viewport" content="width=device-width, initial-scale=1">
            <meta name="robots" content="noindex, nofollow">
            <title>Age Verification - <?php bloginfo('name'); ?></title>
            <?php wp_head(); ?>
        </head>
        <body class="age-verification-page">
            <div class="age-verification-overlay">
                <div class="age-verification-modal">
                    <?php if ($logo_url): ?>
                        <img src="<?php echo esc_url($logo_url); ?>" alt="<?php bloginfo('name'); ?>" class="age-verification-logo">
                    <?php endif; ?>
                    
                    <h1><?php bloginfo('name'); ?></h1>
                    <p class="age-verification-message"><?php echo esc_html($message); ?></p>
                    
                    <div class="age-verification-form">
                        <label for="birth_year">Enter your birth year:</label>
                        <input type="number" id="birth_year" name="birth_year" min="1900" max="<?php echo date('Y'); ?>" placeholder="YYYY" required>
                        
                        <div class="age-verification-buttons">
                            <button type="button" id="verify-age-btn" class="btn-enter">I am <?php echo $minimum_age; ?>+</button>
                            <button type="button" id="exit-btn" class="btn-exit">I am under <?php echo $minimum_age; ?></button>
                        </div>
                        
                        <p class="age-verification-disclaimer">
                            By entering this site, you agree to our <a href="<?php echo get_privacy_policy_url(); ?>" target="_blank">Privacy Policy</a> and <a href="/terms-of-service" target="_blank">Terms of Service</a>.
                        </p>
                    </div>
                    
                    <div class="age-verification-error" style="display: none;">
                        <p>Sorry, you must be <?php echo $minimum_age; ?> or older to access this site.</p>
                    </div>
                </div>
            </div>
            <?php wp_footer(); ?>
        </body>
        </html>
        <?php
    }
    
    /**
     * Handle age verification via AJAX
     */
    public function verify_age() {
        $birth_year = isset($_POST['birth_year']) ? intval($_POST['birth_year']) : 0;
        $minimum_age = get_option('age_verification_minimum_age', 18);
        $current_year = date('Y');
        $age = $current_year - $birth_year;
        
        if ($age >= $minimum_age) {
            // Set cookie
            $cookie_duration = get_option('age_verification_cookie_duration', $this->cookie_duration);
            setcookie(
                $this->cookie_name,
                'yes',
                time() + ($cookie_duration * DAY_IN_SECONDS),
                COOKIEPATH,
                COOKIE_DOMAIN,
                is_ssl(),
                true
            );
            
            wp_send_json_success(array('message' => 'Age verified'));
        } else {
            wp_send_json_error(array('message' => 'Age verification failed'));
        }
    }
    
    /**
     * Enqueue scripts and styles
     */
    public function enqueue_scripts() {
        if (is_admin()) {
            return;
        }
        
        wp_enqueue_style(
            'age-verification-styles',
            plugins_url('css/age-verification.css', __FILE__),
            array(),
            '1.0.0'
        );
        
        wp_enqueue_script(
            'age-verification-script',
            plugins_url('js/age-verification.js', __FILE__),
            array('jquery'),
            '1.0.0',
            true
        );
        
        wp_localize_script('age-verification-script', 'ageVerification', array(
            'ajaxurl' => admin_url('admin-ajax.php'),
            'nonce' => wp_create_nonce('age_verification_nonce'),
            'minimum_age' => get_option('age_verification_minimum_age', 18)
        ));
    }
    
    /**
     * Add admin menu
     */
    public function add_admin_menu() {
        add_options_page(
            'Age Verification Settings',
            'Age Verification',
            'manage_options',
            'age-verification',
            array($this, 'settings_page')
        );
    }
    
    /**
     * Register settings
     */
    public function register_settings() {
        register_setting('age_verification_settings', 'age_verification_minimum_age');
        register_setting('age_verification_settings', 'age_verification_message');
        register_setting('age_verification_settings', 'age_verification_cookie_duration');
        register_setting('age_verification_settings', 'age_verification_logo');
    }
    
    /**
     * Settings page
     */
    public function settings_page() {
        ?>
        <div class="wrap">
            <h1>Age Verification Settings</h1>
            <form method="post" action="options.php">
                <?php settings_fields('age_verification_settings'); ?>
                <?php do_settings_sections('age_verification_settings'); ?>
                
                <table class="form-table">
                    <tr>
                        <th scope="row">
                            <label for="age_verification_minimum_age">Minimum Age</label>
                        </th>
                        <td>
                            <input type="number" id="age_verification_minimum_age" name="age_verification_minimum_age" value="<?php echo esc_attr(get_option('age_verification_minimum_age', 18)); ?>" min="18" max="21" class="small-text">
                            <p class="description">Minimum age required to access the site (18 or 21)</p>
                        </td>
                    </tr>
                    
                    <tr>
                        <th scope="row">
                            <label for="age_verification_message">Verification Message</label>
                        </th>
                        <td>
                            <textarea id="age_verification_message" name="age_verification_message" rows="3" cols="50" class="large-text"><?php echo esc_textarea(get_option('age_verification_message', 'You must be 18 years or older to enter this site.')); ?></textarea>
                            <p class="description">Message displayed on the age verification page</p>
                        </td>
                    </tr>
                    
                    <tr>
                        <th scope="row">
                            <label for="age_verification_cookie_duration">Remember Duration</label>
                        </th>
                        <td>
                            <input type="number" id="age_verification_cookie_duration" name="age_verification_cookie_duration" value="<?php echo esc_attr(get_option('age_verification_cookie_duration', 30)); ?>" min="1" max="365" class="small-text"> days
                            <p class="description">How long to remember verified users (1-365 days)</p>
                        </td>
                    </tr>
                    
                    <tr>
                        <th scope="row">
                            <label for="age_verification_logo">Logo URL</label>
                        </th>
                        <td>
                            <input type="url" id="age_verification_logo" name="age_verification_logo" value="<?php echo esc_url(get_option('age_verification_logo', get_site_icon_url())); ?>" class="large-text">
                            <p class="description">Logo to display on age verification page (leave blank for site icon)</p>
                        </td>
                    </tr>
                </table>
                
                <?php submit_button(); ?>
            </form>
        </div>
        <?php
    }
}

// Initialize plugin
new BongStore_Age_Verification();

