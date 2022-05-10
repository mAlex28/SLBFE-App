import React from 'react';
import { Card, CardActions, CardContent, Typography, CardHeader, IconButton } from '@material-ui/core/';
import EmailIcon from '@material-ui/icons/Email'
import { Link } from 'react-router-dom';
import moment from 'moment';


const Complain = ({ complain }) => {
    return (
        <Card
            elevation={5}
            style={{
                padding: '10px',
                marginTop: '10px',
                marginBottom: '10px',
            }}
        >
            <CardHeader
                title={complain.complainTitle}
                subheader={complain.email}
            />
            <CardContent>
                <Typography variant="body2" color="textPrimary">
                    {complain.complainText.split(' ').splice(0, 50).join(' ')}...
                </Typography>
                <Typography variant="body2" color="textSecondary">
                    {moment(complain.createdAt).fromNow()}
                </Typography>
            </CardContent>
            <CardActions disableSpacing>
                <Link
                    to="#"
                    onClick={() => (window.location.href = `mailto:${complain.email}`)}
                >
                    <IconButton aria-label="email" color="primary">
                        <EmailIcon />
                    </IconButton>
                </Link>
            </CardActions>
        </Card>
    );
};

export default Complain;

