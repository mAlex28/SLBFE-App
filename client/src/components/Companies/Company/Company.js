import React, { useState } from 'react';
import { Card, CardActions, CardContent, Button, Typography, CardHeader, Avatar, IconButton } from '@material-ui/core/';
import PhoneInTalkIcon from '@material-ui/icons/PhoneInTalk'
import EmailIcon from '@material-ui/icons/Email'
import { useHistory, Link } from 'react-router-dom';

import useStyles from './styles';

const Company = ({ company }) => {
    const history = useHistory();

    const viewCompanies = (e) => {
        history.push(`/companies/${company._id}`);
    };

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
                style={{
                    cursor: 'pointer'
                }}
                onClick={viewCompanies}
                avatar={

                    <Avatar style={{ backgroundColor: '#34495e' }} aria-label="avatar">
                        {company.companyName.charAt(0)}
                    </Avatar>

                }
                title={company.companyName}
                subheader={company.country}
            />
            <CardContent>
                <Typography variant="body2" color="textPrimary">
                    {company.description.split(' ').splice(0, 50).join(' ')}...
                </Typography>
            </CardContent>
            <div
                style={{
                    display: 'flex',
                    justifyContent: 'space-between',
                    margin: '20px',
                }}
            >
                <Typography variant="body2" color="textSecondary" component="p">
                    {company.companyFields.map((fields) => `#${fields} `)}
                </Typography>
            </div>
            <CardActions disableSpacing>
                <Link
                    to="#"
                    onClick={() => (window.location.href = `tel:${company.contact}`)}
                >
                    <IconButton aria-label="call" color="primary">
                        <PhoneInTalkIcon />
                    </IconButton>
                </Link>
                <Link
                    to="#"
                    onClick={() => (window.location.href = `mailto:${company.email}`)}
                >
                    <IconButton aria-label="email" color="primary">
                        <EmailIcon />
                    </IconButton>
                </Link>
            </CardActions>
        </Card>
    );
};

export default Company;

