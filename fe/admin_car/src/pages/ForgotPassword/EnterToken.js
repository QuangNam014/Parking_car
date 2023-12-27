import imgPath from './images';

function EnterToken() {
    return (
        <div class="main">
            <section class="signup">
                <div class="container">
                    <div class="signup-content">
                        <div class="signup-form">
                            <h2 class="form-title">Sign up</h2>
                            <form method="POST" class="register-form" id="register-form">
                                <div class="form-group">
                                    <label for="pass">
                                        <i class="zmdi zmdi-lock"></i>
                                    </label>
                                    <input type="password" name="pass" id="pass" placeholder="Password" />
                                </div>
                                <div class="form-group form-button">
                                    <input
                                        type="submit"
                                        name="signup"
                                        id="signup"
                                        class="form-submit"
                                        value="Confirm"
                                    />
                                </div>
                            </form>
                        </div>
                        <div class="signup-image">
                            <figure>
                                <img src={imgPath} />
                            </figure>
                        </div>
                    </div>
                </div>
            </section>
        </div>
    );
}

export default EnterToken;
