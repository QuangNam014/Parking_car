import { useEffect, useState } from 'react';
import imgPath from './images';
import { sendEmailToken, checkEmailExistence, verifiedToken } from '~/utils';
import { useNavigate } from 'react-router-dom';
import { Button } from '@mui/material';
import { Spinner } from 'react-bootstrap';

function ForgotPassword() {
    const [email, setEmail] = useState('');
    const [isEmailValid, setIsEmailValid] = useState(false);
    const [isSubmitSuccess, setIsSubmitSuccess] = useState(false);
    const [otpCode, setOtpCode] = useState('');
    const [sendingEmail, setSendingEmail] = useState(false);
    const navigate = useNavigate();

    useEffect(() => {
        console.log(email);
        checkEmailExistence(email)
            .then((response) => {
                setIsEmailValid(true);
            })
            .catch((error) => {
                setIsEmailValid(false);
                // console.error('Lỗi khi kiểm tra sự tồn tại của email:', error);
            });
    }, [email]);

    const handleEmailChange = (event) => {
        setEmail(event.target.value);
    };

    // const handleCheckEmailExistence = async (event) => {
    //     event.preventDefault();
    //     try {
    //         const response = await checkEmailExistence(email);
    //         setIsEmailValid(response.exists);
    //     } catch (error) {
    //         console.error('Lỗi khi kiểm tra sự tồn tại của email:', error);
    //     }
    // };

    const handSubmitOTP = async () => {
        try {
            const response = await verifiedToken(email, otpCode);
            console.log(response);
            navigate('/newPassword');
        } catch (error) {
            console.error('Lỗi:', error);
        }
    };

    const handleSubmit = async (event) => {
        event.preventDefault();

        try {
            const dataToSend = {
                email: email,
            };
            console.log('Phản hồi từ API:');
            setSendingEmail(true);
            const response = await sendEmailToken(dataToSend);
            console.log('Phản hồi từ API:', response);
            // Tiếp tục quá trình khôi phục mật khẩu
            setIsSubmitSuccess(!isSubmitSuccess);
        } catch (error) {
            // console.error('Lỗi:', error);
        } finally {
            setSendingEmail(false);
        }
    };

    return (
        <div className="main">
            <section className="signup">
                <div className="container">
                    <div className="signup-content">
                        <div className="signup-form">
                            <h2 className="form-title">Forgot password</h2>
                            <form method="POST" className="register-form" id="register-form" onSubmit={handleSubmit}>
                                <div className="form-group">
                                    <label htmlFor="email">
                                        <i className="zmdi zmdi-email"></i>
                                    </label>
                                    {/* Sử dụng giá trị email từ state và gọi hàm xử lý khi có thay đổi */}
                                    <input
                                        type="email"
                                        name="email"
                                        id="email"
                                        placeholder="Your Email"
                                        value={email}
                                        onChange={handleEmailChange}
                                    />
                                </div>
                                {isEmailValid ? <span>Email is exist</span> : <span>Email is not exist</span>}

                                <div className="form-group form-button">
                                    {isSubmitSuccess ? (
                                        <></>
                                    ) : (
                                        <button
                                            type="submit"
                                            name="signup"
                                            id="signup"
                                            className="form-submit"
                                            // value="Get password"
                                            disabled={!isEmailValid}
                                        >
                                            {sendingEmail ? 'Loading....' : 'Get password'}
                                        </button>
                                    )}
                                </div>
                            </form>
                            {isSubmitSuccess && (
                                <>
                                    <input
                                        type="text"
                                        placeholder="Insert your OTP code"
                                        onChange={(e) => {
                                            setOtpCode(e.target.value);
                                        }}
                                    ></input>
                                    <input
                                        type="button"
                                        onClick={handSubmitOTP}
                                        className="form-submit"
                                        value="Confirm send OTP"
                                        readOnly
                                    />
                                </>
                            )}
                        </div>
                        <div className="signup-image">
                            <figure>
                                {/* Thêm đường dẫn hình ảnh của bạn vào đây */}
                                <img src={imgPath} alt="Signup" />
                            </figure>
                        </div>
                    </div>
                </div>
            </section>
        </div>
    );
}

export default ForgotPassword;
