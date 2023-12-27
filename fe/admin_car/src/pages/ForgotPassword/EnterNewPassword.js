import imgPath from './images';
import * as yup from 'yup';
import * as formik from 'formik';
import { useState } from 'react';
import { changePassword } from '~/utils';
import { Alert, Spinner } from 'react-bootstrap';
import { Link } from 'react-router-dom';

function EnterNewPassword() {
    const [isLoading, setIsLoading] = useState(false);
    const [variant, setVariant] = useState('info');
    const [errorMessage, setErrorMessage] = useState(null);

    const schema = yup.object().shape({
        email: yup.string().email().required(),
        password: yup.string().min(3, 'Please, at least 3 character!...').required(),
        confirmPassword: yup
            .string()
            .oneOf([yup.ref('password'), null], 'confirm password must match')
            .required(),
    });

    const handleSubmit = async (values, { setSubmitting }) => {
        try {
            setErrorMessage(null);
            setIsLoading(true);
            const email = values.email;
            const pass = values.password;
            const conPass = values.confirmPassword;
            const response = await changePassword(email, pass, conPass);
            console.log(response);
            setVariant('success');
            setErrorMessage('Success change password');
        } catch (error) {
            setVariant('danger');
            setErrorMessage('Failure');
        } finally {
            setIsLoading(false);
            setSubmitting(false);
        }
    };

    return (
        <div class="main">
            <section class="signup">
                <div class="container">
                    <div class="signup-content">
                        <div class="signup-form">
                            <h2 class="form-title">Sign up</h2>

                            <formik.Formik
                                validationSchema={schema}
                                onSubmit={handleSubmit}
                                initialValues={{
                                    email: '',
                                    password: '',
                                    confirmPassword: '',
                                }}
                            >
                                {({ handleSubmit, handleChange, values, touched, errors }) => (
                                    <formik.Form
                                        method="POST"
                                        class="register-form"
                                        id="register-form"
                                        onSubmit={handleSubmit}
                                    >
                                        <div class="form-group">
                                            <label for="email">
                                                <i class="zmdi zmdi-email"></i>
                                            </label>
                                            <input
                                                type="email"
                                                name="email"
                                                id="email"
                                                placeholder="Your Email"
                                                onChange={handleChange}
                                                value={values.email}
                                                isInvalid={touched.email && !!errors.email}
                                            />
                                            <span style={{ color: 'red' }}>{errors.email}</span>
                                        </div>
                                        <div class="form-group">
                                            <label for="pass">
                                                <i class="zmdi zmdi-lock"></i>
                                            </label>
                                            <input
                                                type="password"
                                                name="password"
                                                id="password"
                                                placeholder="Password"
                                                onChange={handleChange}
                                                value={values.password}
                                                isInvalid={touched.password && !!errors.password}
                                            />
                                            <span style={{ color: 'red' }}>{errors.password}</span>
                                        </div>
                                        <div class="form-group">
                                            <label for="re-pass">
                                                <i class="zmdi zmdi-lock-outline"></i>
                                            </label>
                                            <input
                                                type="password"
                                                name="confirmPassword"
                                                id="confirmPassword"
                                                placeholder="Repeat your password"
                                                onChange={handleChange}
                                                value={values.confirmPassword}
                                                isInvalid={touched.confirmPassword && !!errors.confirmPassword}
                                            />
                                            <span style={{ color: 'red' }}>{errors.confirmPassword}</span>
                                        </div>
                                        {errorMessage && (
                                            <>
                                                <Alert style={{ color: 'green' }} variant={variant}>
                                                    {errorMessage}
                                                </Alert>
                                                <Link to="/">Login</Link>
                                            </>
                                        )}
                                        <div class="form-group form-button">
                                            <button
                                                type="submit"
                                                name="signup"
                                                id="signup"
                                                class="form-submit"
                                                disabled={isLoading}
                                            >
                                                {isLoading ? 'Loading....' : ' Change Password'}
                                            </button>
                                        </div>
                                    </formik.Form>
                                )}
                            </formik.Formik>
                        </div>
                        <div class="signup-image">
                            <figure>
                                <img src={imgPath} />
                            </figure>
                            <a href="#" class="signup-image-link">
                                I am already member
                            </a>
                        </div>
                    </div>
                </div>
            </section>
        </div>
    );
}

export default EnterNewPassword;
